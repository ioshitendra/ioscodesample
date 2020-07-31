

class reviewTVC: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
}

import UIKit

class ReviewVC: UIViewController {
    var objuserReviews =  [UserReviews]()
    var objViewReview = ReviewViewModel()
    var ids = ""
    var url = ""
    @IBOutlet weak var tblReview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        print(objuserReviews)
    }
    
}

extension ReviewVC {
    func setUp(){
        ReviewApiCall()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        setNavigationBarStyle(transparent: false, leftButton: true, rightButton: false, title:"Review")
        tblReview.rowHeight = UITableView.automaticDimension
        tblReview.estimatedRowHeight = 110.0
        
    }
}

extension ReviewVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objuserReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblReview.dequeueReusableCell(withIdentifier: "reviewTVC", for: indexPath) as! reviewTVC
        cell.selectionStyle = .none
        cell.lblName.text = objuserReviews[indexPath.row].userName
        cell.lblRating.text = "\(objuserReviews[indexPath.row].reviewRating ?? 0)"
        cell.lblDate.text = objuserReviews[indexPath.row].reviewDate
        cell.lblDesc.text = objuserReviews[indexPath.row].review
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

extension ReviewVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ReviewVC {
    
    func ReviewApiCall() {
        print_QT4DebugMode()
        Global.showLoadingSpinner()
        objViewReview.APICall(url: url + ids) { (responseArray) in
            Global.dismissLoadingSpinner()
            if(responseArray.statusCode == 200){
                let obj  = responseArray.response ?? [ReviewResponse]()
                if(obj.count>0){
                    self.objuserReviews = obj[0].response
                    self.tblReview.reloadData()
                }
                
            }else{
                Global.showAlertWithMessage(message: "Data not found.")
            }
        }
    }
    
}
