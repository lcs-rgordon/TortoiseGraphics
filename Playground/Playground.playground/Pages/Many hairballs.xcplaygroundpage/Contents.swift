import PlaygroundSupport
import TortoiseGraphics
import CoreGraphics

let myFrame = CGRect(x: 0, y: 0, width: 500, height: 500)
let canvas = PlaygroundCanvas(frame: myFrame)
canvas.frameRate = 300
canvas.color = .white
PlaygroundPage.current.liveView = canvas

/**
 Draws a squiggly line.
 
 - parameter with: The Tortoise object that will do the drawing.
 - parameter s: How long the individual squiggle should be.
 */
func randomTravel(with t : Tortoise, size s : Int) {
    
    // Draw the line
    for _ in 1...s {
        
        // Turn a bit
        let turn = t.random(20) - 10
        t.left(turn)
        
        // Draw a random line length
        let distance = t.random(10)
        t.forward(distance)
        
    }
    
}

/**
 Draws a hairball (also kind of looks like a spider!)
 
 - parameter with: The Tortoise object that will do the drawing.
 - parameter atX: Horizontal position for centre point of the hairball / spider.
 - parameter atY: Vertical position for centre point of the hairball / spider.
 */
func hairball(with t: Tortoise, atX x : Double, atY y : Double) {
    
    // Go to the centre point
    t.penUp()
    t.goto(x, y)
    t.penDown()
    
    // Draw the hairball
    for _ in 1...25 {
        
        // Turn a random amount
        let turn = t.random(360)
        t.left(turn)
        
        // Draw a squiggly line
        randomTravel(with: t, size: 10)
        
        // Return to centre point of this hairball
        t.penUp()
        t.goto(x, y)
        t.setHeading(0)
        t.penDown()
        
    }

}

canvas.drawing { turtle in
    
    // Draw a grid of hairballs
    hairball(with: turtle, atX: -125, atY: 125)
    hairball(with: turtle, atX: 0, atY: 125)
    hairball(with: turtle, atX: 125, atY: 125)
    hairball(with: turtle, atX: -125, atY: 0)
    hairball(with: turtle, atX: 0, atY: 0)
    hairball(with: turtle, atX: 125, atY: 0)
    hairball(with: turtle, atX: -125, atY: -125)
    hairball(with: turtle, atX: 0, atY: -125)
    hairball(with: turtle, atX: 125, atY: -125)

    // Hide the turtle when done
    turtle.hideTortoise()
    
}
