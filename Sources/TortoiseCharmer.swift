import Foundation
import os.log

extension Collection where Indices.Iterator.Element == Index {
    subscript (exist index: Index) -> Iterator.Element? {
        // Does the collection contain the index in question?
        // If yes, return the value at that index.
        // If no, return nil.
        return indices.contains(index) ? self[index] : nil
        // In theory, this should avoid index out of range errors.
        // In practice, even after an index is found, returning the value on
        // that found index sometimes fails, which is very odd.
        // It seems like the array of Tortoise commands changes on the fly
        // (threading problems?)
    }
}

class TortoiseCharmer {

    private(set) var tortoises: [Tortoise] = []
    private(set) var commandHistories: [(tortoiseTag: Int, commandIndex: Int)] = []
    private var priorCommandHistoriesCount: Int = 0
    private var commandHistoriesUnchangedCount: Int = 0

    var commandedHandler: ((TortoiseCharmer) -> Void)?

    init(tortoiseCount: Int = 1) {
        initialize(tortoiseCount: tortoiseCount)
    }

    func initialize(tortoiseCount: Int = 1) {
        assert(tortoiseCount > 0)
        tortoises = []
        commandHistories = []
        priorCommandHistoriesCount = 0
        commandHistoriesUnchangedCount = 0
        for index in 0..<tortoiseCount {
            let tortoise = Tortoise()
            tortoise.tag = index
            tortoise.commandedHandler = { [unowned self] (tortoise) in
                self.commandHistories.append((tortoiseTag: tortoise.tag,
                                              commandIndex: tortoise.commands.count - 1))
                self.commandedHandler?(self)
            }
            tortoises.append(tortoise)
        }
    }

    @discardableResult
    func charm(with context: GraphicsContext, toFrame index: Int?) -> Int {
        let endIndex = commandHistories.count - 1
        let toIndex = min(max((index ?? endIndex), 0), endIndex)

        context.setup()

        var states = [State](repeating: State(), count: tortoises.count)
        for index in 0..<tortoises.count {
            states[index].canvasSize = context.size
        }

        // Original code
//        for (index, history) in commandHistories.enumerated() where index <= toIndex {
//            states[history.tortoiseTag] =
//                tortoises[history.tortoiseTag]
//                    .commands[history.commandIndex]
//                    .exexute(in: states[history.tortoiseTag], with: context.cgContext)
//        }

//        // Attempted fix #1
//        // The use of the extension to Collection type should guarantee
//        // that no index out of range errors are encountered, but it still happens
//        for (index, history) in commandHistories.enumerated() where index <= toIndex {
//            // Try to verify that the index exists ...
//            if tortoises[history.tortoiseTag].commands[exist: history.commandIndex] != nil {
//                // ... before attempting to use it.
//                states[history.tortoiseTag] = tortoises[history.tortoiseTag]
//                                                .commands[history.commandIndex]
//                                                .exexute(in: states[history.tortoiseTag], with: context.cgContext)
//            }
//        }

//        // Attempted fix #2
//        // Make a copy of the array of Tortoise commands and work from this
//        // so that the list of commands doesn't change under our feet.
//        //
//        // NOTE: This appears to work but feels like a bad solution.
//        // NOTE: Unsure how, or whether, this fix can scale to work with multiple tortoises.
//        let commandsToRun = tortoises[0].commands
//        for (index, history) in commandHistories.enumerated() where index <= toIndex {
//            if commandsToRun[exist: history.commandIndex] != nil {
//                states[history.tortoiseTag] = commandsToRun[history.commandIndex]
//                                                .exexute(in: states[history.tortoiseTag], with: context.cgContext)
//            }
//        }

//        // Attempted fix #3
//        // Make a copy of the array of Tortoise commands for each Tortoise
//        // NOTE: Again, while this works, it doesn't feel elegant
//        var commandsToRun = [ Int: [Command] ]()
//        for (index, tortoise) in tortoises.enumerated() {
//            commandsToRun[index] = tortoise.commands
//        }
//        // Now iterate over all the commands in the command history and run
//        // using the copy of commands for each tortoise (saved a moment ago)
//        for (index, history) in commandHistories.enumerated() where index <= toIndex {
//
//            // Get commands out of the dictionary for the current tortoise
//            if let commands = commandsToRun[history.tortoiseTag] {
//
//                // Try to avoid index out of range rrors
//                if commands[exist: history.commandIndex] != nil {
//
//                    // Actually run the command at the given index
//                    states[history.tortoiseTag] = commands[history.commandIndex]
//                        .exexute(in: states[history.tortoiseTag], with: context.cgContext)
//                }
//            }
//        }

        // Revised fix
        // Has the main thread finished adding commands to the tortoises and history?
        // In other words, have the Tortoise commands arrays stabilized?
        // (Defining "stable" as this method being called five times with unchanged counts)
        if priorCommandHistoriesCount == commandHistories.count {
            if commandHistoriesUnchangedCount < 5 {
                commandHistoriesUnchangedCount += 1
            }
        } else {
            // Command histories count changed, reset counter
            commandHistoriesUnchangedCount = 0
        }

        os_log("Command histories unchanged for %d calls", commandHistoriesUnchangedCount)

        // Commands arrays are not being changed by other thread, so we can use them directly
        if commandHistoriesUnchangedCount == 5 {

            // If so, we can safely use the commands array on each Tortoise instance
            for (index, history) in commandHistories.enumerated() where index <= toIndex {
                states[history.tortoiseTag] =
                    tortoises[history.tortoiseTag]
                        .commands[history.commandIndex]
                        .exexute(in: states[history.tortoiseTag], with: context.cgContext)
            }

            os_log("ran original code")

        } else {

            // Commands arrays still being changed by other thread.
            //
            // So, make a local copy of the commands array for each Tortoise instance for use in this thread
            // to avoid index out of range errors (when commands array on Tortoise instances are modified by
            // the main thread)
            var commandsToRun = [ Int: [Command] ]()
            for (index, tortoise) in tortoises.enumerated() {
                commandsToRun[index] = tortoise.commands
            }

            // Now iterate over all the commands in the command history and run
            // using the copy of commands for each tortoise (saved a moment ago)
            for (index, history) in commandHistories.enumerated() where index <= toIndex {

                // Get commands out of the dictionary for the current tortoise
                if let commands = commandsToRun[history.tortoiseTag] {

                    // Try to avoid index out of range rrors
                    if commands[exist: history.commandIndex] != nil {

                        // Actually run the command at the given index
                        states[history.tortoiseTag] = commands[history.commandIndex]
                            .exexute(in: states[history.tortoiseTag], with: context.cgContext)
                    }
                }
            }

            os_log("ran modified code")

        }

        // Save the count of command histories to refer to next time this method is called
        priorCommandHistoriesCount = commandHistories.count

        // More testing to determine what array is encountering an index out of range exception
//        for (index, history) in commandHistories.enumerated() where index <= toIndex {
//            let statesIndexValid = states.indices.contains(history.tortoiseTag)
//            let tortoiseIndexValid = tortoises.indices.contains(history.tortoiseTag)
//            let tortoiseCommandsIndexValid = tortoises[history.tortoiseTag].commands.indices.contains(history.commandIndex)
//
//            if statesIndexValid && tortoiseIndexValid && tortoiseCommandsIndexValid {
//                states[history.tortoiseTag] =
//                    tortoises[history.tortoiseTag]
//                        .commands[history.commandIndex]
//                        .exexute(in: states[history.tortoiseTag], with: context.cgContext)
//            } else {
//                os_log("//////")
//                os_log("Gotcha")
//                statesIndexValid ? os_log("statesIndexValid is true") : os_log("statesIndexValid is false")
//                tortoiseIndexValid ? os_log("tortoiseIndexValid is true") : os_log("tortoiseIndexValid is false")
//                tortoiseCommandsIndexValid ? os_log("tortoiseCommandIndexValid is true") : os_log("tortoiseCommandIndexValid is false")
//                os_log("tortoises[0].commands.count = %d", tortoises[0].commands.count)
//                os_log("history.commandIndex = %d", history.commandIndex)
//                os_log("//////")
//            }
//        }

        for index in 0..<tortoises.count {
            let state = states[index]
            if state.isVisible {
                tortoises[index].drawTortoise(context.cgContext, state: state)
            }
        }

        context.tearDown()
        return min(toIndex + 1, endIndex)
    }

}
