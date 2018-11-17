//: # With a tortoise 🐢
//: [👉 With 2 tortoises 🐢🐢](@next)
import PlaygroundSupport
import TortoiseGraphics
import CoreGraphics

let myFrame = CGRect(x: 0, y: 0, width: 500, height: 500)
let canvas = PlaygroundCanvas(frame: myFrame)
canvas.frameRate = 300
canvas.color = .white
PlaygroundPage.current.liveView = canvas

func dashedCircle(with t : Tortoise) {
    
    // Adjust course to the left a bit
    t.penUp()
    t.forward(10)
    t.right(5)
    t.forward(10)
    t.right(5)

    // Draw a dashed circle
    for _ in 1...36 {
        t.penUp()
        t.forward(9)
        t.right(5)
        t.penDown()
        t.forward(11)
        t.right(5)
    }
}

canvas.drawing { turtle in
    
    // Move drawing left a bit
    turtle.penUp()
    turtle.right(90)
    turtle.backward(50)
    turtle.left(90)
    turtle.penDown()
    turtle.penSize(2)
    
    // Draw 18 dashed circles
    for _ in 1...18 {
        dashedCircle(with: turtle)
        turtle.right(10)
    }
    
    // Hide the tortoise
    turtle.hideTortoise()
}
