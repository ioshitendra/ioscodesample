

import UIKit

public class ValidationRules: NSObject {
    
    public class func isBlankText(text:AnyObject) -> Bool {
        
        var returnValue:Bool = false
        
        if text is UITextField == true {
            
            let thetext = (text as! UITextField).text
            let trimmedString = thetext!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if trimmedString.isEmpty {
                returnValue  = true
            }
        } else if text is UITextView == true {
            
            let thetext = (text as! UITextView).text
            let trimmedString = thetext!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if trimmedString.isEmpty {
                returnValue  = true
            }
        } else if text is NSString == true {
            
            let thetext = text as! String
            let trimmedString = thetext.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if trimmedString.isEmpty {
                returnValue  = true
            }
        }
        return returnValue
    }
    
    public class func isValidEmail(EmailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        //let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = EmailStr.range(of: emailRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        return !result
    }
    
    public class func isValidPassword(PasswordStr:String) -> Bool {
        // Alternative Regexes
        
        // 8 characters. One uppercase
        // static let regex = "^(?=.*?[A-Z]).{8,}$"
        //
        // 8 characters. One uppercase. One Lowercase. One number.
        // static let regex = "^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[a-z]).{8,}$"
        //
        // no length. One uppercase. One lowercae. One number.
        // static let regex = "^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[a-z]).*?$"
        
        let regex = ".{6,}$"    //"^(?=.*?[0-9])(?=.[$@$#!%?&])(?=.*?[A-z]).{5,}$"  // at least one digit one number and one special character and a length of at least 5
        let range = PasswordStr.range(of: regex, options:.regularExpression)
        let result = range != nil ? true : false
        return !result
    }
    
    public class func isValidProfile(PasswordStr:String) -> Bool {
        if PasswordStr == "Choose Profile" {
            return true
            
        }
        return false
    }
    
    public class func isValidPhoneNumber(PhoneStr:String) -> Bool {
        
        let phoneRegEx = "^\\d{8}$"
        let range = PhoneStr.range(of: phoneRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        return !result
    }
    
    public class func isValidCountryCode(CodeStr: String) -> Bool {
        
        let phoneRegEx = "^\\d{3}$"
        let range = CodeStr.range(of: phoneRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        return !result
    }
    
    public class func isValid11DigitPhoneNumber(PhoneStr:String) -> Bool {
        
        let phoneRegEx = "^\\d{11}$"
        let range = PhoneStr.range(of: phoneRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        return !result
    }
    
    
    public class func isValidUrl (stringURL : String) -> Bool {
        
        let urlRegEx = "((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let range = stringURL.range(of: urlRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        return !result
    }
    
}

