

import UIKit

class ThankyouVC: BaseViewController {

    @IBOutlet weak var lblBottom: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
         setUI()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ThankyouVC {
    func setUI(){
         self.tabBarController?.tabBar.isHidden = false
        let attributedString = NSMutableAttributedString(string: "Check your email: info@q-tickets.com", attributes: [
          .font: UIFont(name: "Montserrat-Regular", size: 13.0)!,
          .foregroundColor: UIColor(red: 17.0 / 255.0, green: 37.0 / 255.0, blue: 64.0 / 255.0, alpha: 1.0),
          .kern: -0.52
        ])
        attributedString.addAttribute(.font, value: UIFont(name: "Montserrat-Medium", size: 13.0)!, range: NSRange(location: 18, length: 18))
        lblBottom.attributedText =  attributedString
    }
}
