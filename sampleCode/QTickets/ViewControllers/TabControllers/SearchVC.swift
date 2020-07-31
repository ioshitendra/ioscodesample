
import UIKit

class SearchVC: BaseViewController {
    
    @IBOutlet weak var scrlView: UIScrollView!
    @IBOutlet weak var tblViewSearch: UITableView!
    @IBOutlet weak var txtFieldSearch: UITextField!
    
    var searchViewModel = SearchViewModel()
    var headingArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        headingArray = ["Movies", "Events", "Sports", "Leisure"]
        self.setHeading()
        self.tblViewSearch.register(UINib(nibName: XIBTableCell.qSearchCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifier.qSearchCellIdentifier)
        self.txtFieldSearch.delegate = self
        self.tblViewSearch.dataSource = self
        self.tblViewSearch.delegate = self
    }
    
    
    func setHeading() {
        print_QT4DebugMode()
        
        for i in 1...headingArray.count {
            let itemButton = UIButton()
            itemButton.frame = CGRect(x: 20.0 + CGFloat(i - 1) * Constants.SCREEN_WIDTH / CGFloat(headingArray.count), y: 0, width: Constants.SCREEN_WIDTH / CGFloat(headingArray.count), height: 50)
            itemButton.titleLabel?.font = FontHelper.MontserratLightFontWithSize(size: 14)
            itemButton.titleLabel?.textColor = UIColor.white
            itemButton.contentMode = .scaleAspectFit
            itemButton.layer.borderColor = UIColor.white.cgColor
            itemButton.layer.borderWidth = 1.0
            itemButton.layer.cornerRadius = 14.0
            itemButton.tag = i
            itemButton.setTitle("  \(self.headingArray[i-1])  ", for: .normal)
            itemButton.sizeToFit()
            self.scrlView.addSubview(itemButton)
        }
        self.scrlView.contentSize.width = CGFloat(93*headingArray.count)
    }
}


//MARK: API Calling Methods
extension SearchVC {
    
    func APICall(query: String) {
        print_QT4DebugMode()
        
        let url: String = "\(APIURL.SEARCH_URL)&search=\(query)&Country=\(Constants.DEFAULT_COUNTRY)"
        searchViewModel.APICall(url: url) { (responseArray) in
            for obj in responseArray {
                //  self.imageUrlArray.append("http:\(obj.imagepath ?? "")")
                print_QT4DebugModeSimpleForm(items: obj)
            }
            // self.loadBanners()
        }
    }
}


//MARK: UITextField Delegates
extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField .resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text != "" {
            self.APICall(query: textField.text ?? "")
            return true
        }
        
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       // textField.text = ""
    }
}


//MARK: UITableViewDelegate Methods
extension SearchVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SearchCell = tblViewSearch.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.qSearchCellIdentifier, for: indexPath) as! SearchCell
        
        return cell
    }
    
}


//MARK: UITableViewDelegate Methods
extension SearchVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 52
    }
}

extension SearchVC {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

