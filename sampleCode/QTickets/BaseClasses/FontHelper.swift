

import UIKit

public struct FontHelper {
    
    public enum Montserrat: String {
        
        case Light        = "Montserrat-Light"
        case Regular      = "Montserrat-Regular"
        case Medium       = "Montserrat-Medium"
        case Semibold     = "Montserrat-SemiBold"
        case Bold         = "Montserrat-Bold"
    }
    
    public static func MontserratLightFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: Montserrat.Light.rawValue, size: size)!
    }
    
    public static func MontserratRegularFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: Montserrat.Regular.rawValue, size: size)!
    }
    
    public static func MontserratMediumFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: Montserrat.Medium.rawValue, size: size)!
    }
    
    public static func MontserratSemiboldFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: Montserrat.Semibold.rawValue, size: size)!
    }
    
    public static func MontserratBoldFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: Montserrat.Bold.rawValue, size: size)!
    }

}

