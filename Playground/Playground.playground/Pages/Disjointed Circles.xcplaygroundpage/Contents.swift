import PlaygroundSupport
import TortoiseGraphics
import CoreGraphics

let myFrame = CGRect(x: 0, y: 0, width: 500, height: 500)
let canvas = PlaygroundCanvas(frame: myFrame)
canvas.frameRate = 300
canvas.color = .white
PlaygroundPage.current.liveView = canvas

/**
 Draws `n` line segments.
 
 - parameter tortoise: The Tortoise object that will do the drawing.
 - parameter segments: Number of line segments to be drawn.
 - parameter length: The length of each line segement to be drawn.
 - parameter angle: Degrees to turn before drawing next segement.
 
 */
func polyline(tortoise : Tortoise, segmentCount segments : Int, length : Double, angle : Double) {
    for _ in 1...segments {
        tortoise.forward(length)
        tortoise.left(angle)
    }
}

/**
 Draws an arc with the given radius and angle.
 
 - parameter tortoise: The Tortoise object that will do the drawing.
 - parameter radius: The radius of the circle to be drawn.
 - parameter angle: The angle subtended by the arc, in degrees.
 
 */
func arc(tortoise : Tortoise, radius : Double, angle : Int) {
    
    // Source: https://bit.ly/2K9JWbz
    let arcLength = 2 * Double.pi * radius * Double(abs(angle)) / 360
    let segments = Int(arcLength / 4) + 1
    let stepLength = arcLength / Double(segments)
    let stepAngle = Double(angle) / Double(segments)
    
    // Making a slight left turn before starting reduces the error
    // caused by the linear approximation of the arc
    tortoise.left(stepAngle / 2)
    polyline(tortoise: tortoise, segmentCount: segments, length: stepLength, angle: stepAngle)
    tortoise.right(stepAngle / 2)
}

canvas.drawing { turtle in
    
    // Draw 10 semi-circles of increasing radius size
    for i in 1...10 {
        arc(tortoise: turtle, radius: 10 * Double(i), angle: 180) // Draw a semi-circle
        turtle.penUp()
        turtle.left(90)
        turtle.forward(10)
        turtle.right(90)
        turtle.penDown()
    }
    turtle.hideTortoise()
    
}
