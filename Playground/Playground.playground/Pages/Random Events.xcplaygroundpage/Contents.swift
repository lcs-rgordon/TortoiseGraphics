import PlaygroundSupport
import TortoiseGraphics
import CoreGraphics

let myFrame = CGRect(x: 0, y: 0, width: 500, height: 500)
let canvas = PlaygroundCanvas(frame: myFrame)
canvas.frameRate = 300
canvas.color = .white
PlaygroundPage.current.liveView = canvas

canvas.drawing { turtle in
    
    for _ in 1...100 {
        
        // Turn a random amount
        let turn = turtle.random(360)
        turtle.left(turn)
        
        // Draw a random line length
        let distance = turtle.random(250)
        turtle.forward(distance)
        
        // Go back to centre of canvas and original heading
        turtle.penUp()
        turtle.goto(0, 0)
        turtle.setHeading(0)
        turtle.penDown()
        
    }
    
    // Hide the turtle when done
    turtle.hideTortoise()
    
}
