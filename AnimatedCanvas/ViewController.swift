//
//  ViewController.swift
//  AnimatedDraw
//
//  Created by Russell Gordon on 11/8/18.
//

import Cocoa
import TortoiseGraphics

class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let myFrame = CGRect(x: 0, y: 0, width: 800, height: 600)
        let canvas = PlaygroundCanvas(frame: myFrame)
        canvas.frameRate = 300
        canvas.color = .white
        self.view = canvas

        canvas.drawingWithTortoises(count: 2) { t in

            let 🐢 = t[0]
            let 🐇 = t[1]

            // Start drawing name from top left corner of canvas
            🐢.penUp()
            🐢.goto(-350, 150)

            // Start drawing name from top left corner of canvas
            🐇.penUp()
            🐇.goto(-350, -50)

            // Set pen width and make other tortoise draw in different colour
            🐢.penSize(5)
            🐇.penSize(5)
            🐇.penColor(.blue)

            // Hide turtle because the icon gets larger when the
            // pen size is increased
            🐢.hideTortoise()
            🐇.hideTortoise()

            // Face to the right
            🐢.setHeading(90)
            🐇.setHeading(90)
            
            // Draw my first name
            🐢.uppercaseR()
            🐇.uppercaseR()
            🐢.lowercaseU()
            🐇.lowercaseU()
            🐢.lowercaseS()
            🐇.lowercaseS()
            🐢.lowercaseS()
            🐇.lowercaseS()
            🐢.lowercaseE()
            🐇.lowercaseE()
            🐢.lowercaseL()
            🐇.lowercaseL()
            🐢.lowercaseL()
            🐇.lowercaseL()

            // Move over a bit
            🐢.setHeading(90)
            🐢.forward(25)
            🐇.setHeading(90)
            🐇.forward(25)

            // Draw my last name
            🐢.uppercaseG()
            🐇.uppercaseG()
            🐢.lowercaseO(returnToBaseline: false)
            🐇.lowercaseO(returnToBaseline: false)
            🐢.lowercaseR(startFromBaseline: false)
            🐇.lowercaseR(startFromBaseline: false)
            🐢.lowercaseD()
            🐇.lowercaseD()
            🐢.lowercaseO(returnToBaseline: false)
            🐇.lowercaseO(returnToBaseline: false)
            🐢.lowercaseN(startFromBaseline: false)
            🐇.lowercaseN(startFromBaseline: false)

        }
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
}

