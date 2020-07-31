

import UIKit

class seatTVC: UITableViewCell {
    
}

class MovieSeatLaoutVC: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setNavigationBarStyle(transparent: false, leftButton: true, rightButton: false, title: "key_seat_laout".localized())
        tblView.delegate = self
        tblView.dataSource = self
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func ContinueAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "EventBooking", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifier.qPaymentSummeryIdentifire) as! PaymentSummeryVC
               self.navigationController?.setNavigationBarHidden(true, animated: true)
               self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MovieSeatLaoutVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "seatTVC", for: indexPath) as! seatTVC
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 345
    }
    
}


extension MovieSeatLaoutVC : UITableViewDelegate{
    
}
