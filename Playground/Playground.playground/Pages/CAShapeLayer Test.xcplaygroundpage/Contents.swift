import AppKit
import PlaygroundSupport

// Give NSBezierPath ability to return a CGPath
public extension NSBezierPath {
    
    public var cgPath: CGPath {
        let path = CGMutablePath()
        var points = [CGPoint](repeating: .zero, count: 3)
        for i in 0 ..< self.elementCount {
            let type = self.element(at: i, associatedPoints: &points)
            switch type {
            case .moveTo: path.move(to: points[0])
            case .lineTo: path.addLine(to: points[0])
            case .curveTo: path.addCurve(to: points[2], control1: points[0], control2: points[1])
            case .closePath: path.closeSubpath()
            }
        }
        return path
    }
    
}

// Make a basic view and display it
let myFrame = CGRect(x: 0, y: 0, width: 400, height: 200)
let myView = NSView(frame: myFrame)
PlaygroundPage.current.liveView = myView

// Create a CAShapeLayer instance, add to view, and configure
var myCAShapeLayer = CAShapeLayer()
myView.layer = myCAShapeLayer
myCAShapeLayer.bounds = CGRect(x: 0, y: 0, width: myFrame.width, height: myFrame.height)
myCAShapeLayer.position = CGPoint(x: 0, y: 0)
myCAShapeLayer.lineWidth = 2.0
myCAShapeLayer.fillColor = nil
myCAShapeLayer.backgroundColor = NSColor(hue: 80/360.0, saturation: 0.8, brightness: 0.9, alpha: 1.0).cgColor
myCAShapeLayer.strokeColor = NSColor(hue: 0, saturation: 0, brightness: 0, alpha: 1).cgColor

// Add a single line
var firstPath = NSBezierPath()
firstPath.move(to: CGPoint(x: 0, y: 0))
firstPath.line(to: CGPoint(x: 10, y: 5))
firstPath.lineWidth = 2.0

// Make a second line (copy first path then add next path)
var secondPath = firstPath.copy() as! NSBezierPath
secondPath.line(to: CGPoint(x: 200, y: 100))

// Set the initial path for the shape layer
myCAShapeLayer.path = firstPath.cgPath

// Animate the addition to the line
let pathAnimation = CABasicAnimation(keyPath: "path")
pathAnimation.toValue = secondPath.cgPath
pathAnimation.duration = 10.0
pathAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
pathAnimation.autoreverses = false
// Make sure the state when animation is complete remains visible
pathAnimation.isRemovedOnCompletion = false
pathAnimation.fillMode = CAMediaTimingFillMode.forwards

// Add and run the animation
myCAShapeLayer.add(pathAnimation, forKey: "path")

