import Foundation

open class Color {
    
    // Static properties for convenience for basic colors
    public static let black : Color = Color(hue: 0, saturation: 0, brightness: 0, alpha: 100)
    public static let white : Color = Color(hue: 0, saturation: 0, brightness: 100, alpha: 100)
    public static let red : Color = Color(hue: 0, saturation: 80, brightness: 90, alpha: 100)
    public static let orange : Color = Color(hue: 30, saturation: 80, brightness: 90, alpha: 100)
    public static let yellow : Color = Color(hue: 60, saturation: 80, brightness: 90, alpha: 100)
    public static let green : Color = Color(hue: 120, saturation: 80, brightness: 90, alpha: 100)
    public static let blue : Color = Color(hue: 240, saturation: 80, brightness: 90, alpha: 100)
    public static let purple : Color = Color(hue: 270, saturation: 80, brightness: 90, alpha: 100)
    
    
    var hue: Float = 0.0 {
        didSet {
            hue = self.rationalizeToSinglePositiveRotation(hue)
            self.translatedHue = CGFloat(self.hue / 360)
        }
    }
    
    var saturation: Float = 0.0 {
        didSet {
            saturation = self.rationalizePercentage(saturation)
            self.translatedSaturation = CGFloat(self.saturation / 100)
        }
    }
    
    var brightness: Float = 0.0 {
        didSet {
            brightness = self.rationalizePercentage(brightness)
            self.translatedBrightness = CGFloat(self.brightness / 100)
        }
    }
    
    var alpha: Float = 0.0 {
        didSet {
            alpha = self.rationalizePercentage(alpha)
            self.translatedAlpha = CGFloat(self.alpha / 100)
        }
    }
    
    var translatedHue : CGFloat = 0.0
    var translatedSaturation : CGFloat = 0.0
    var translatedBrightness : CGFloat = 0.0
    var translatedAlpha : CGFloat = 0.0
    
    public init(hue: Float, saturation: Float, brightness: Float, alpha: Float) {
        
        // Set with provided values, but translate to valid values first
        self.hue = rationalizeToSinglePositiveRotation(hue)
        self.saturation = rationalizePercentage(saturation)
        self.brightness = rationalizePercentage(brightness)
        self.alpha = rationalizePercentage(alpha)
        
        // Prepare values to provide to NSColor initializer
        self.translatedHue = CGFloat(self.hue / 360)
        self.translatedSaturation = CGFloat(self.saturation / 100)
        self.translatedBrightness = CGFloat(self.brightness / 100)
        self.translatedAlpha = CGFloat(self.alpha / 100)
        
    }
    
    // Allow integer inputs to be used to set color values as well
    public convenience init(hue: Int, saturation: Int, brightness: Int, alpha: Int) {
        
        self.init(hue: Float(hue), saturation: Float(saturation), brightness: Float(brightness), alpha: Float(alpha))
        
    }
    
    // Takes a given number of degrees and translates to range between 0 and 360
    fileprivate func rationalizeToSinglePositiveRotation(_ value : Float) -> Float {
        
        if value < 0 {
            return 0.0
        } else if value > 360 {
            return value.truncatingRemainder(dividingBy: 360)
        }
        
        return value
        
    }
    
    // Takes a given value and translates to a percentage between 0 and 100
    fileprivate func rationalizePercentage(_ value : Float) -> Float {
        
        if value < 0 {
            return 0.0
        } else if value > 100 {
            return value.truncatingRemainder(dividingBy: 100)
        }
        
        return value
        
    }
    
}

// https://material.io/guidelines/style/color.html
public enum Color: String {

    case black = "000000"
    case white = "FFFFFF"
    case red = "F44336"
    case pink = "E91E63"
    case purple = "9C27B0"
    case deepPurple = "673AB7"
    case indigo = "3F51B5"
    case blue = "2196F3"
    case lightBlue = "03A9F4"
    case cyan = "00BCD4"
    case teal = "009688"
    case green = "4CAF50"
    case lightGreen = "8BC34A"
    case lime = "CDDC39"
    case yellow = "FFEB3B"
    case amber = "FFC107"
    case orange = "FF9800"
    case deepOrange = "FF5722"
    case brown = "795548"
    case grey = "9E9E9E"
    case blueGrey = "607D8B"

}
