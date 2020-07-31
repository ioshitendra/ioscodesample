

import UIKit

extension UIColor {
    
    //MARK: UIColor Codes
    
    
    public class func AppTabBarHighlightedColor() -> UIColor {
        return UIColor(hex: "ee3d38")
    }
    
    public class func AppScrollIndicatorColor() -> UIColor {
        return UIColor(hex: "ffd91d")
    }
    
    public class func AppTabBarUnSelectedColor() -> UIColor {
        return UIColor(hex: "25253b")
    }
    
    public class func AppStatusBarColor() -> UIColor {
        return UIColor(hex: "112540")
    }
    
    public class func HeaderScrollViewColor() -> UIColor {
        return UIColor(hex: "0d213d")
    }
    
    public class func AppTextFieldBorderColor() -> UIColor {
        return UIColor(hex: "95989c")
    }
    
    public class func AppFilterLabelUnselectedColor() -> UIColor {
        return UIColor(hex: "7b7b7b")
    }
    
    public class func AppFilterLabelSelectedColor() -> UIColor {
        return UIColor(hex: "112540")
    }
    
    public class func AppDateLabelDefaultColor() -> UIColor {
        return UIColor.init(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.37)
    }
    
    public class func AppDayLabelDefaultColor() -> UIColor {
        return UIColor(hex: "1D252D")
    }
    
    public class func ApptabelHederlDefaultColor() -> UIColor {
        return UIColor(hex: "E0E1E7")
    }
    
    public class func ApptabelHederlcellColor() -> UIColor {
        return UIColor(hex: "747A82")
    }
    public class func reviewFillStarColor() -> UIColor {
        return UIColor(hex: "EE3D38")
    }
    
    public class func trendingDarkColor() -> UIColor {
        return UIColor(hex: "0b1036")
    }
    
    
    //MARK:-   Hex UIColor extensions
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha:1)
    }
    
    convenience init(hex: String, alpha: CGFloat) {
        var hexWithoutSymbol = hex
        if hexWithoutSymbol.hasPrefix("#") {
            hexWithoutSymbol = ""
        }
        
        let scanner = Scanner(string: hexWithoutSymbol)
        var hexInt:UInt64 = 0x0
        scanner.scanHexInt64(&hexInt)
        
        var r:UInt64!, g:UInt64!, b:UInt64!
        switch (hexWithoutSymbol.count) {
        case 3: // #RGB
            r = ((hexInt >> 4) & 0xf0 | (hexInt >> 8) & 0x0f)
            g = ((hexInt >> 0) & 0xf0 | (hexInt >> 4) & 0x0f)
            b = ((hexInt << 4) & 0xf0 | hexInt & 0x0f)
            break;
        case 6: // #RRGGBB
            r = (hexInt >> 16) & 0xff
            g = (hexInt >> 8) & 0xff
            b = hexInt & 0xff
            break;
        default:
            // TODO:ERROR
            break;
        }
        
        self.init(
            red: (CGFloat(r)/255),
            green: (CGFloat(g)/255),
            blue: (CGFloat(b)/255),
            alpha:alpha)
    }
    
}


