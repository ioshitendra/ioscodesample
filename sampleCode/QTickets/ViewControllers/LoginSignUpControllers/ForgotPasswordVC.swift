

import UIKit
import JVFloatLabeledTextField

class ForgotPasswordVC: BaseViewController {

    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var txtFieldEmail: JVFloatLabeledTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    func setScreenUI() {
        print_QT4DebugMode()
        
    }
    
}

//MARK: API calling Method
extension ForgotPasswordVC {
    
    func ApiCall() {
        print_QT4DebugMode()
        self.dismiss(animated: true, completion: nil)
    }
}


//MARK: Button Action Methods
extension ForgotPasswordVC {
    
    @IBAction func Send(_ sender: Any) {
        print_QT4DebugMode()
        self.ApiCall()
    }
    
    @IBAction func back(_ sender: Any) {
        print_QT4DebugMode()
        self.dismiss(animated: true, completion: nil)
    }
}


//MARK: UITextFieldDelegate
extension ForgotPasswordVC {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField .resignFirstResponder()
        return true
    }
}
extension ForgotPasswordVC {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
