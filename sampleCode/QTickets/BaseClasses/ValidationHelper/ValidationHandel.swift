

import UIKit
import CoreLocation


public class ValidationHandel: NSObject {
    /************************************************************************************************************
     //MARK:-   Validate : Login Form
     ************************************************************************************************************/
    class func validateLoginForm(validateObj: LoginVC) -> Bool {
        
        if ValidationRules.isBlankText(text: validateObj.userNameTextField) {
            Global.showAlertWithMessage(message: ValidationError.OfType.EmptyEmail.description, sender: validateObj)
            return false
        } else if ValidationRules.isValidEmail(EmailStr: validateObj.userNameTextField.text!) {
            Global.showAlertWithMessage(message: ValidationError.OfType.ValidEmail.description, sender: validateObj)
            return false
        } else if ValidationRules.isBlankText(text: validateObj.passwordTextField) {
            Global.showAlertWithMessage(message: ValidationError.OfType.EmptyPassword.description, sender: validateObj)
            return false
        }  else if ValidationRules.isValidPassword(PasswordStr: validateObj.passwordTextField.text!) {
            Global.showAlertWithMessage(message: ValidationError.OfType.ValidPassword.description, sender: validateObj)
            return false
        } else {
            return true
        }
    }
    
}

