
protocol logindelegate {
    func callLogindata()
}


import UIKit
import  JVFloatLabeledTextField
import AuthenticationServices

class LoginVC: BaseViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userNameTextField: JVFloatLabeledTextField!
    @IBOutlet weak var passwordTextField: JVFloatLabeledTextField!
    @IBOutlet weak var btnApple: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    var delegate : logindelegate?
    var eyeClick : Bool = false
    var loginViewModel = LoginViewModel()
    var loggedInUserData = LoginModel(dict: [String: Any]())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setScreenUI()
    }
    
}


//MARK: SET SCREEN UI
extension LoginVC {
    
    func setScreenUI() {
        print_QT4DebugMode()
        
        self.userNameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.btnFacebook.layer.cornerRadius = 5
        self.btnFacebook.clipsToBounds = true
        self.btnGoogle.layer.cornerRadius = 5
        self.btnGoogle.clipsToBounds = true
        self.btnApple.layer.cornerRadius = 5
        self.btnApple.clipsToBounds = true
    }
}


//MARK: Button Action Methods
extension LoginVC {
    
    @IBAction func closeClick(_ sender: UIButton) {
        print_QT4DebugMode()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ForgotPassword(_ sender: Any) {
        print_QT4DebugMode()
        
        let vc = self.storyboard?.instantiateViewController(identifier: ViewControllerIdentifier.qForgotPasswordVCIdentifier) as! ForgotPasswordVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func getParameter()->[String:AnyObject]?{
           
           var param:[String:String] = [String:String]()
          
        param["email"] = userNameTextField.text
        param["password"] = passwordTextField.text
           return (param as [String : AnyObject])
       }
    
    @IBAction func SignIn(_ sender: Any) {
        print_QT4DebugMode()
        
        self.view.endEditing(true)
        if ValidationHandel.validateLoginForm(validateObj: self) {
            guard let param = getParameter() else {
                       return
                   }
            Global.showLoadingSpinner(message: "Loading", sender: self)
            let urlString = APIURL.BASE_URL + APIURL.LOGIN_URL
            print(param)
            loginViewModel.APICall(url: urlString, param: param, completion:  { (responseArray) in
                  Global.dismissLoadingSpinner(sender: self)
                 self.loggedInUserData = responseArray
                 Constants.APP_DELEGATE.user = self.loggedInUserData
                self.delegate?.callLogindata()
                self.dismiss(animated: true, completion: nil)
                // self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                
            }, error: { (error) in
                Global.dismissLoadingSpinner(sender: self)
                Global.showAlertViewController(withTitle: "Error", message: ConstantsMessages.kSomethingWrong, actions: ["OK", "Retry"], andActionCompletionBlock: {buttIndex in
                    if buttIndex == 1 {
                        Global.showLoadingSpinner(message: "Loading..", sender: self)
                        
                    }
                })
            })
//            let loginUrl: String = "\(APIURL.BASE_URL + APIURL.LOGIN_URL)username=\(userNameTextField.text ?? "")&password=\(passwordTextField.text ?? "")&source=4&token="
//            Global.showLoadingSpinner(message: "Loading", sender: self)
//            loginViewModel.APICall(url: loginUrl) { (responseData) in
//                Global.dismissLoadingSpinner(sender: self)
//                self.loggedInUserData = responseData
//                Constants.APP_DELEGATE.user = self.loggedInUserData
//                self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
//            }
        }
    }
    
    @IBAction func SignInWithApple(_ sender: Any) {
        print_QT4DebugMode()
        self.handleAppleIdRequest()
    }

}

//MARK: UITextFieldDelegate
extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField .resignFirstResponder()
        return true
    }
}
extension LoginVC {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension LoginVC {
    
    func handleAppleIdRequest() {
        
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }
    }
}

extension LoginVC: ASAuthorizationControllerDelegate {
    
    @available(iOS 13.0, *)
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let userIdentifier = appleIDCredential.user
            appleIDProvider.getCredentialState(forUserID: userIdentifier) {  (credentialState, error) in
                switch credentialState {
                case .authorized:
                    let firstName = appleIDCredential.fullName?.givenName ?? ""
                    let lastName = appleIDCredential.fullName?.familyName ?? ""
                    let email = appleIDCredential.email ?? ""
                    let name = firstName + " " + lastName
                    print(email)
                    print(name)
                    print(userIdentifier)
                    break
                case .revoked:
                    Global.showAlertWithMessage(message: "The Apple ID credential is revoked.")
                    break
                case .notFound:
                    Global.showAlertWithMessage(message: "No credential was found.")
                    break
                default:
                    break
                }
            }
        }
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension LoginVC: ASAuthorizationControllerPresentationContextProviding {
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window ?? UIWindow()
    }
}
