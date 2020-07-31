

import UIKit
import JVFloatLabeledTextField
import AuthenticationServices

class RegistrationVC: BaseViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var txtFieldFirstName: JVFloatLabeledTextField!
    @IBOutlet weak var txtFieldLastName: JVFloatLabeledTextField!
    @IBOutlet weak var txtFieldEmail: JVFloatLabeledTextField!
    @IBOutlet weak var txtFieldMobile: JVFloatLabeledTextField!
    @IBOutlet weak var txtFieldPasssword: JVFloatLabeledTextField!
    @IBOutlet weak var txtFieldConfirmPassword: JVFloatLabeledTextField!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var btnApple: UIButton!
    
    
    var registrationViewModel = RegistrationViewModel()
    var registeredUserData = RegistrationModel(dict: [String: Any]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetScreenUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
}


//MARK: Set Screen UI
extension RegistrationVC {
    
    func SetScreenUI() {
        
        print_QT4DebugMode()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tapGesture)
        self.txtFieldFirstName.delegate = self
        self.txtFieldLastName.delegate = self
        self.txtFieldEmail.delegate = self
        self.txtFieldPasssword.delegate = self
        self.txtFieldConfirmPassword.delegate = self
        self.txtFieldMobile.delegate = self
        self.btnFacebook.layer.cornerRadius = 5
        self.btnFacebook.clipsToBounds = true
        self.btnGoogle.layer.cornerRadius = 5
        self.btnGoogle.clipsToBounds = true
        self.btnApple.layer.cornerRadius = 5
        self.btnApple.clipsToBounds = true
    }
}


//MARK: Selector Functions
extension RegistrationVC {
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
    }
}


//MARK: API Calling Methods
extension RegistrationVC {
    
    func SignUpAPICall() {
        print_QT4DebugMode()
        
        let regUrl: String = "\(APIURL.REG_URL)firstname=\(txtFieldFirstName.text ?? "")&lastname=&prefix=&phone=\(txtFieldMobile.text ?? "")&mailid=\(txtFieldEmail.text ?? "")&pwd=\(txtFieldPasssword.text ?? "")&confirmpwd=\(txtFieldPasssword.text ?? "")&fid=&nationality=&dob=&gender=&source=4&token="
        Global.showLoadingSpinner(message: "Loading", sender: self)
        registrationViewModel.APICall(url: regUrl) { (responseData) in
            Global.dismissLoadingSpinner(sender: self)
            self.registeredUserData = responseData
            print_QT4DebugModeSimpleForm(items: self.registeredUserData)
            self.dismiss(animated: true, completion: nil)
        }
    }
}


//MARK: Button Action Methods
extension RegistrationVC {
    
    
    @IBAction func closeClick(_ sender: Any) {
        print_QT4DebugMode()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        print_QT4DebugMode()
        
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func SignUp(_ sender: Any) {
        print_QT4DebugMode()
        self.SignUpAPICall()
    }
    
    @IBAction func SignUpWithApple(_ sender: Any) {
        print_QT4DebugMode()
        self.handleAppleIdRequest()
    }
}


//MARK: UITextField Delegates
extension RegistrationVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField .resignFirstResponder()
        return true
    }
    
}
extension RegistrationVC {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


extension RegistrationVC {
    
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


extension RegistrationVC: ASAuthorizationControllerDelegate {
    
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

extension RegistrationVC: ASAuthorizationControllerPresentationContextProviding {
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window ?? UIWindow()
    }
}
