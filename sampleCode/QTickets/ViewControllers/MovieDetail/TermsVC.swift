
import UIKit

class TermsVC: BaseViewController {

  @IBOutlet weak var lblTerms: UILabel!
  var objTermsViewModel = TermsViewModel()
   // var termsString = ""
    var objTermsResponse = [TermsResponse]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        setNavigationBarStyle(transparent: false, leftButton: true, rightButton: false, title:"Terms & Conditions")
        TermsApiCall()
    }
}

extension TermsVC {
    
    func TermsApiCall() {
        print_QT4DebugMode()
        Global.showLoadingSpinner()
        objTermsViewModel.APICall(url: APIURL.BASE_URL + APIURL.Terms) { (responseArray) in
            Global.dismissLoadingSpinner()
            if(responseArray.statusCode == 200){
                self.objTermsResponse = responseArray.response ?? [TermsResponse]()
                if(self.objTermsResponse.count>0){
                self.lblTerms.text = self.objTermsResponse[0].response
                }
               
            }else{
                Global.showAlertWithMessage(message: "Data not found.")
            }
        }
    }
    
}
