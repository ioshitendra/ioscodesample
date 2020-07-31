

import UIKit

class AccountVC: BaseViewController {
    
    @IBOutlet weak var tblViewAccount: UITableView!
    
    var loginTitles = [String]()
    var titleArray = [String]()
    var userId = String()
    var userName = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userId = Constants.APP_DELEGATE.user != nil ? Constants.APP_DELEGATE.user.id ?? "" : ""
        userName = Constants.APP_DELEGATE.user != nil ? Constants.APP_DELEGATE.user.name ?? "" : ""
        self.setScreenUI()
        self.tblViewAccount.reloadData()
    }

    
    func registerTableView() {
        print_QT4DebugMode()
        
        self.tblViewAccount.register(UINib(nibName: XIBTableCell.qAccountTableHeaderCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifier.qAccountHeaderCellIdentifier)
        self.tblViewAccount.register(UINib(nibName: XIBTableCell.qAccountTableItemCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifier.qAccountTableItemCellIdentifier)
        self.tblViewAccount.delegate = self
        self.tblViewAccount.dataSource = self
    }

}

//MARK: SET SCREEN UI
extension AccountVC {
    
    func setScreenUI() {
        print_QT4DebugMode()
        
        loginTitles = ["My Booking", "Notification", "Contact Us", "Rate Us", "Invite & Earn", "Terms & Condition", "About Us"]
        titleArray = ["mybooking", "notification", "contactus", "rateus", "invite&earn", "terms&Conditions", "aboutUs"]
        
        registerTableView()
    }
}

//MARK: UITableViewDataSource and Delegates
extension AccountVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {
            return 1
        } else {
            return loginTitles.count
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section==0 {
            return 150.0
        } else {
            return 60.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell: SideMenuTableHeaderCell! = tblViewAccount.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.qAccountHeaderCellIdentifier) as? SideMenuTableHeaderCell
            cell.selectionStyle=UITableViewCell.SelectionStyle.none
            if self.userId != "" {
                cell.loginview.isHidden=true
                cell.logoutBtn.isHidden=false
            } else {
                cell.loginview.isHidden=false
                cell.logoutBtn.isHidden=true
            }
            cell.userNameLbl.text = "Welcome " + self.userName
            cell.profileimg.image = UIImage (named: "avatar")
            cell.logoutBtn .addTarget(self, action:#selector(self.logoutClick), for: .touchUpInside)
            cell.loginBtn .addTarget(self, action: #selector(self.loginClick), for: .touchUpInside)
            cell.signupBtn .addTarget(self, action:#selector(self.SignupClick), for: .touchUpInside)
            return cell
        } else {
            let cell1: SideMenuTableItemCell! = tblViewAccount.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.qAccountTableItemCellIdentifier) as? SideMenuTableItemCell
            cell1.titleLablel.text = loginTitles[indexPath.row]
            cell1.itemImage.image = UIImage(named: titleArray[indexPath.row])
            cell1.selectionStyle=UITableViewCell.SelectionStyle.none
            return cell1
        }
    }
}


//MARK: Selector Functions
extension AccountVC {
    
    @objc func loginClick() {
        print_QT4DebugMode()
        
        let storyboard = UIStoryboard(name: StoryboardName.qLoginSIgnUp, bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifier.qLoginVCIdentifier) as! LoginVC
        loginVC.modalPresentationStyle = .fullScreen
        loginVC.delegate = self
        self.present(loginVC, animated: true, completion: nil)
    }
    
    
    @objc func SignupClick() {
        print_QT4DebugMode()
        
        let storyboard = UIStoryboard(name: StoryboardName.qLoginSIgnUp, bundle: nil)
        let regVC = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifier.qSignUpVCIdentifier) as! RegistrationVC
        regVC.modalPresentationStyle = .fullScreen
        self.present(regVC, animated: true, completion: nil)
    }
    
    
   
    
    
    @objc func logoutClick() {
        print_QT4DebugMode()
        
        Global.showAlertViewController(withTitle: "key_title_logout".localized(), message: "key_logout_message".localized(), actions: ["key_alert_ok".localized(),"key_alert_cancel".localized()]) { (selection) in
            if(selection == 0) {
                self.tabBarController?.selectedIndex = 0
            }
        }
    }

}
extension AccountVC {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension AccountVC: logindelegate {
    func callLogindata() {
        tblViewAccount.reloadData()
    }
    
    
}
