

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class PaymentSummeryVC: UIViewController {

    @IBOutlet weak var dassedTralling: UILabel!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var dassedLeading: UILabel!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewG: UIView!
    @IBOutlet weak var viewFB: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnGuest: UIButton!
    @IBOutlet weak var txtFieldEmail: MDCOutlinedTextField!
    @IBOutlet weak var txtFieldPassword: MDCOutlinedTextField!
    @IBOutlet weak var stackViewLogin: UIStackView!
    @IBOutlet weak var stackViewLoginHeightConstrant: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    

   // MARK: - Button Action Method
        
        
    @IBAction func ProcceToPayAction(_ sender: Any) {
            let storyboard = UIStoryboard(name: StoryboardName.thankingyouStoryboard, bundle: nil)
            let paymentSummeryVC = storyboard.instantiateViewController(identifier: ViewControllerIdentifier.qthankingyou) as! ThankyouVC
            self.navigationController?.pushViewController(paymentSummeryVC, animated: true)
        }
    
    @IBAction func LoginAction(_ sender: Any) {
//        stackViewLogin.isHidden = false
//        stackViewLoginHeightConstrant.constant = 340
        
        btnLogin.backgroundColor = UIColor.AppStatusBarColor()
        btnLogin.setTitleColor(UIColor.white, for: .normal)
        
        btnGuest.backgroundColor = UIColor.white
        btnGuest.setTitleColor(UIColor.AppDayLabelDefaultColor(), for: .normal)
        btnGuest.layer.borderColor = UIColor.AppDayLabelDefaultColor().cgColor
        btnGuest.layer.borderWidth = 0.5
        
       
    }
    
    @IBAction func GuestAction(_ sender: Any) {
        // stackViewLogin.isHidden = true
       //  stackViewLoginHeightConstrant.constant = 0
        
        btnGuest.backgroundColor = UIColor.AppStatusBarColor()
        btnGuest.setTitleColor(UIColor.white, for: .normal)
               
        btnLogin.backgroundColor = UIColor.white
        btnLogin.setTitleColor(UIColor.AppDayLabelDefaultColor(), for: .normal)
        btnLogin.layer.borderColor = UIColor.AppDayLabelDefaultColor().cgColor
        btnLogin.layer.borderWidth = 0.5
    }
    
        
        @IBAction func BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ForgotPasswordAction(_ sender: UIButton) {
        
    }
    
 // MARK: - Custom Method to set ui
   func setupUI(){
    
//  stackViewLogin.isHidden = false
    btnGuest.layer.borderWidth = 0.5
    btnGuest.layer.borderColor = UIColor.lightGray.cgColor
    txtFieldEmail.label.text = "Email"
    txtFieldPassword.label.text = "Password"
    txtFieldPassword.isSecureTextEntry = true
    
    viewFB.layer.cornerRadius = 4
    viewG.layer.cornerRadius = 4
    
    drawDottedLine(start: CGPoint(x: dassedLeading.bounds.minX, y: dassedLeading.bounds.minY), end: CGPoint(x: dassedLeading.bounds.maxX, y: dassedLeading.bounds.minY), view: dassedLeading)
    drawDottedLine(start: CGPoint(x: dassedTralling.bounds.minX, y: dassedTralling.bounds.minY), end: CGPoint(x: dassedTralling.bounds.maxX, y: dassedTralling.bounds.minY), view: dassedTralling)
    }
    
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UILabel) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3] // 7 is the length of dash, 3 is length of the gap.

        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }
}
