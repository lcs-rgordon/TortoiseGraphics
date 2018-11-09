public extension Tortoise {

    func square(withSize size: Double) {

        self.penDown()
        for _ in 1...4 {
            self.forward(size)
            self.right(90)
        }
        self.penUp()
    }

    func curve(withSides sideCount: Int, withSize size: Double, drawSides sideLimit: Int) {

        self.penDown()
        for _ in 1...sideLimit {
            self.forward(size)
            self.right(360 / Double(sideCount))
        }
        self.penUp()

    }

    func uppercaseR() {

        // Stick on left side
        self.penDown()
        self.left(80)
        self.forward(70)

        // Turn around and go down a bit
        self.right(180)
        self.forward(10)

        // Turn left for top part of bubble
        self.left(145)
        self.curve(withSides: 40, withSize: 4, drawSides: 15)

        // Curve in tight back toward stick
        self.curve(withSides: 50, withSize: 1, drawSides: 9)
        self.curve(withSides: 100, withSize: 3, drawSides: 15)

        // Turn down and make final leg
        self.left(150)
        self.penDown()
        self.forward(30)

        // Final curve
        self.curve(withSides: -45, withSize: 3, drawSides: 7)

        // Heading adjustment
        self.left(2.8)

    }

    func lowercaseU() {

        // Curve up
        self.curve(withSides: -40, withSize: 1.5, drawSides: 9)

        // Go straight up self. top
        self.penDown()
        self.forward(15)

        // Turn around
        self.right(180)

        // Loop down
        self.curve(withSides: -60, withSize: 2, drawSides: 10)

        // Bottom of loop on u
        self.curve(withSides: -80, withSize: 0.5, drawSides: 9)

        // Curve up
        self.curve(withSides: -40, withSize: 1.5, drawSides: 9)

        // Go straight up self. top
        self.penDown()
        self.forward(10)

        // Turn around
        self.right(180)

        // Loop down
        self.curve(withSides: -60, withSize: 2, drawSides: 10)

        // Bottom of loop on u
        self.curve(withSides: -80, withSize: 0.5, drawSides: 8)

        // Slight course correction
        self.left(1.5)

    }

    func lowercaseS() {

        // Swoop up
        self.curve(withSides: -50, withSize: 1, drawSides: 7)
        self.curve(withSides: -120, withSize: 1, drawSides: 8)
        self.penDown()
        self.forward(10)

        // Turn around
        self.right(113)

        // Draw back self. base
        self.curve(withSides: 60, withSize: 3, drawSides: 4)
        self.curve(withSides: 60, withSize: 0.75, drawSides: 30)

        // Turn around
        self.right(160)
        self.curve(withSides: -120, withSize: 0.75, drawSides: 25)

        // Course correction
        self.right(32.4)

    }

    func lowercaseE() {

        // Swoop up
        self.curve(withSides: -90, withSize: 0.7, drawSides: 3)
        self.curve(withSides: -200, withSize: 0.8, drawSides: 24)

        // Turn around
        self.curve(withSides: -60, withSize: 0.45, drawSides: 36)

        // Swoop down
        self.curve(withSides: -45, withSize: 1.8, drawSides: 11)

        // Slight course correction
        self.left(0.8)

    }

    func lowercaseL() {

        // Swoop up
        self.curve(withSides: -20, withSize: 3, drawSides: 3)
        self.curve(withSides: -240, withSize: 2, drawSides: 24)

        // Turn around
        self.curve(withSides: -40, withSize: 0.75, drawSides: 16)
        self.curve(withSides: -60, withSize: 0.75, drawSides: 4)

        // Swoop down
        self.curve(withSides: -200, withSize: 2, drawSides: 22)

        // Final curve
        self.curve(withSides: -40, withSize: 1.75, drawSides: 7)

        // Course correction
        self.right(0.61)

    }

    func uppercaseG() {

        // Uppercase G

        // Long loop up
        self.curve(withSides: -80, withSize: 4, drawSides: 22)

        // Turn around at top
        self.curve(withSides: -60, withSize: 0.45, drawSides: 24)

        // Swoop up to point
        self.curve(withSides: -20, withSize: 5, drawSides: 10)
        self.penDown()
        self.forward(10)

        // Swoop back down
        self.right(165)
        self.forward(25)
        self.curve(withSides: 40, withSize: 4.5, drawSides: 18)

        // Final little tail
        self.right(145)
        self.curve(withSides: -60, withSize: 3, drawSides: 15)

        // Get turtle to bottom right corner of "box" around this letter
        self.penUp()
        self.setHeading(90)
        self.forward(20)
        self.right(90)
        self.forward(17)
        self.left(90)

    }

    func lowercaseO(returnToBaseline: Bool = true) {

        // Lowercase o

        // Starting tail
        self.curve(withSides: -80, withSize: 1, drawSides: 20)

        // Loop all the way around
        self.curve(withSides: 80, withSize: 1, drawSides: 20)
        self.curve(withSides: 20, withSize: 1.9, drawSides: 5)
        self.curve(withSides: 55, withSize: 3, drawSides: 3)
        self.curve(withSides: 120, withSize: 1, drawSides: 15)

        // Connect back with start of "o"
        self.curve(withSides: 40, withSize: 1, drawSides: 15)

        // Get back to top of "o"
        self.setHeading(90)
        self.forward(18)
        self.left(90)
        self.forward(16)
        self.setHeading(120)

        // Little ending tail
        self.curve(withSides: -120, withSize: 0.6, drawSides: 20)

        // Course correction
        self.right(30)

        if returnToBaseline {

            // Course correcction
            self.left(30)

            // Sharp turn down to baseline
            self.curve(withSides: 40, withSize: 0.25, drawSides: 17)
            self.curve(withSides: -60, withSize: 2.25, drawSides: 10)

            // Turn back to start next letter
            self.curve(withSides: -40, withSize: 0.25, drawSides: 12)

            // Course correction
            self.right(45)

        }

    }

    func lowercaseR(startFromBaseline: Bool = true) {

        // Lowercase r

        if startFromBaseline {
            // Left arm moving up
            self.left(25)
            self.curve(withSides: -120, withSize: 2, drawSides: 16)
            self.right(73)
        }

        // Middle part down and to the right
        self.left(73)
        self.right(115)
        self.penDown()
        self.forward(10)

        // Final swoop
        self.right(90)
        self.curve(withSides: -120, withSize: 0.75, drawSides: 14)
        self.curve(withSides: -40, withSize: 1, drawSides: 15)

        // Course correction
        self.right(45)

    }

    func lowercaseD() {

        // Lowercase d

        // Slight starting tail
        self.left(10)
        self.curve(withSides: -120, withSize: 0.75, drawSides: 15)

        // Curve toward stick
        self.curve(withSides: 240, withSize: 1, drawSides: 30)

        // Turn around and go to baseline
        self.right(180)
        self.curve(withSides: -240, withSize: 1, drawSides: 30)
        self.curve(withSides: -40, withSize: 1, drawSides: 15)

        // Swoop up to stick
        self.curve(withSides: -120, withSize: 1, drawSides: 20)
        self.penDown()
        self.forward(45)

        // Turn around and go back to baseline
        self.left(180)
        self.forward(45)

        // Curve back up to get to next letter
        self.curve(withSides: -40, withSize: 1, drawSides: 10)

        // Course correction
        self.left(20)
    }

    func lowercaseN(startFromBaseline: Bool = true) {

        if startFromBaseline {

            // Loop up
            self.curve(withSides: -80, withSize: 1, drawSides: 12)
            self.penDown()
            self.forward(20)
            self.curve(withSides: 40, withSize: 1, drawSides: 6) // Heading is 90 degrees now

        }

        // Loop down
        self.curve(withSides: 40, withSize: 0.75, drawSides: 12)
        self.penDown()
        self.forward(20)

        // Go back up and curve around
        self.left(180)
        self.forward(20)
        self.curve(withSides: 40, withSize: 1.5, drawSides: 10)
        self.curve(withSides: 28, withSize: 2, drawSides: 7)

        // Back to baseline
        self.penDown()
        self.forward(6)
        self.curve(withSides: -40, withSize: 1, drawSides: 15)

        // Course correction
        self.right(27)
    }

    func printLocationAndHeading() {
        print("x position is: \(self.xcor)")
        print("y position is: \(self.ycor)")
        print("current heading is: \(self.heading)")
    }

}
