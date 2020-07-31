
import UIKit

class BookDateTimeEventVC: UIViewController {
    
    @IBOutlet weak var clcViewTime: UICollectionView!
    @IBOutlet weak var clcViewDate: UICollectionView!
    @IBOutlet weak var viewPlatinum: UIView!
    @IBOutlet weak var viewSilver: UIView!
    @IBOutlet weak var viewGold: UIView!
    @IBOutlet weak var stackViewPlatinum: UIStackView!
    @IBOutlet weak var stackViewGold: UIStackView!
    @IBOutlet weak var stackViewSilver: UIStackView!
    @IBOutlet weak var lblPlatinum: UILabel!
    @IBOutlet weak var lblPlatinumPrice: UILabel!
    @IBOutlet weak var lblPlatinumCount: UILabel!
    @IBOutlet weak var btnPlatinum: UIButton!
    
    @IBOutlet weak var lblGold: UILabel!
    @IBOutlet weak var lblGoldPrice: UILabel!
    @IBOutlet weak var lblGoldCount: UILabel!
    @IBOutlet weak var btnGold: UIButton!
    
    @IBOutlet weak var lblSilver: UILabel!
    @IBOutlet weak var lblSilverPrice: UILabel!
    @IBOutlet weak var lblSilverCount: UILabel!
    @IBOutlet weak var btnSilver: UIButton!
    
    var CountPlatinum = 1
    var CountGold = 1
    var CountSilver = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    
    // MARK: - Button Action Method
    
    
    @IBAction func ContinueAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: StoryboardName.eventBookingStoryboard, bundle: nil)
        let paymentSummeryVC = storyboard.instantiateViewController(identifier: ViewControllerIdentifier.qPaymentSummeryIdentifire) as! PaymentSummeryVC
        self.navigationController?.pushViewController(paymentSummeryVC, animated: true)
    }
    
    @IBAction func BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func openGoogleMaps(_ sender: Any) {
        print_QT4DebugMode()
        
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
            let url = URL(string: "comgooglemaps://?saddr=&daddr=\(Constants.LATITUDE),\(Constants.LONGITUDE)&directionsmode=driving")
            if #available(iOS 10, *) {
                UIApplication.shared.open(url!)
            } else {
                UIApplication.shared.openURL(url!)
            }
        } else {
            Global.showAlertWithMessage(message: "Unable to open Google maps")
        }
    }
    
    
    @IBAction func AddPlatinumAction(_ sender: Any) {
        viewPlatinum.backgroundColor = UIColor.AppStatusBarColor()
        viewGold.backgroundColor = UIColor.white
        viewSilver.backgroundColor = UIColor.white
        btnPlatinum.isHidden = true
        btnGold.isHidden = false
        btnSilver.isHidden = false
        stackViewPlatinum.isHidden = false
        
        lblPlatinum.textColor = UIColor.white
        lblPlatinumPrice.textColor = UIColor.white
        
        lblGold.textColor = UIColor.AppDayLabelDefaultColor()
        lblGoldPrice.textColor = UIColor.AppDayLabelDefaultColor()
        
        lblSilver.textColor = UIColor.AppDayLabelDefaultColor()
        lblSilverPrice.textColor = UIColor.AppDayLabelDefaultColor()
        
        lblPlatinumCount.text = "1"
        lblSilverCount.text = "1"
        lblGoldCount.text = "1"
        
    }
    
    @IBAction func AddGoldAction(_ sender: Any) {
        viewGold.backgroundColor = UIColor.AppStatusBarColor()
        viewPlatinum.backgroundColor = UIColor.white
        viewSilver.backgroundColor = UIColor.white
        btnPlatinum.isHidden = false
        btnGold.isHidden = true
        btnSilver.isHidden = false
        stackViewGold.isHidden = false
        
        lblPlatinum.textColor = UIColor.AppDayLabelDefaultColor()
        lblPlatinumPrice.textColor = UIColor.AppDayLabelDefaultColor()
        
        lblGold.textColor = UIColor.white
        lblGoldPrice.textColor = UIColor.white
        
        lblSilver.textColor = UIColor.AppDayLabelDefaultColor()
        lblSilverPrice.textColor = UIColor.AppDayLabelDefaultColor()
        
        viewPlatinum.layer.borderColor = UIColor.lightGray.cgColor
        viewPlatinum.layer.borderWidth = 0.5
        
        lblPlatinumCount.text = "1"
        lblSilverCount.text = "1"
        lblGoldCount.text = "1"
        
    }
    
    @IBAction func AddSilverAction(_ sender: Any) {
        viewSilver.backgroundColor = UIColor.AppStatusBarColor()
        viewPlatinum.backgroundColor = UIColor.white
        viewGold.backgroundColor = UIColor.white
        btnPlatinum.isHidden = false
        btnGold.isHidden = false
        btnSilver.isHidden = true
        stackViewSilver.isHidden = false
        
        lblPlatinum.textColor = UIColor.AppDayLabelDefaultColor()
        lblPlatinumPrice.textColor = UIColor.AppDayLabelDefaultColor()
        
        lblGold.textColor = UIColor.AppDayLabelDefaultColor()
        lblGoldPrice.textColor = UIColor.AppDayLabelDefaultColor()
        
        lblSilver.textColor = UIColor.white
        lblSilverPrice.textColor = UIColor.white
        
        
        viewPlatinum.layer.borderColor = UIColor.lightGray.cgColor
        viewPlatinum.layer.borderWidth = 0.5
        
        lblPlatinumCount.text = "1"
        lblSilverCount.text = "1"
        lblGoldCount.text = "1"
        
    }
    
    
    @IBAction func PlatinumMinusAction(_ sender: Any) {
        
        if(CountPlatinum == 1){
            
        }else{
            CountPlatinum = CountPlatinum - 1
            lblPlatinumCount.text = String(CountPlatinum)
        }
        
        
    }
    @IBAction func PlatinumPluseAction(_ sender: Any) {
        CountPlatinum = CountPlatinum + 1
        lblPlatinumCount.text =  String(CountPlatinum)
    }
    
    @IBAction func GoldMinusAction(_ sender: Any) {
        if(CountGold == 1){
            
        }else{
            CountGold = CountGold - 1
            lblGoldCount.text = String(CountGold)
        }
    }
    @IBAction func GoldPluseAction(_ sender: Any) {
        CountGold = CountGold + 1
        lblGoldCount.text =  String(CountGold)
    }
    
    @IBAction func SilverMinusAction(_ sender: Any) {
        if(CountSilver == 1){
            
        }else{
            CountSilver = CountSilver - 1
            lblSilverCount.text = String(CountSilver)
        }
    }
    @IBAction func SilverPluseAction(_ sender: Any) {
        CountSilver = CountSilver + 1
        lblSilverCount.text =  String(CountSilver)
    }
    
    
    // MARK: - Custom Method
    func setupUI(){
        
        viewGold.layer.borderColor = UIColor.lightGray.cgColor
        viewGold.layer.borderWidth = 0.5
        viewGold.layer.cornerRadius = 8
        
        viewSilver.layer.borderColor = UIColor.lightGray.cgColor
        viewSilver.layer.borderWidth = 0.5
        viewSilver.layer.cornerRadius = 8
        
        viewPlatinum.layer.cornerRadius = 8
        
        
    }
    
}
extension BookDateTimeEventVC {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

//MARK: UICollectionView Data Source
extension BookDateTimeEventVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == clcViewDate){
            return 4
        }else{
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == clcViewDate){
            let dateClcCell: DateCell = clcViewDate.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifier.qDateCellIdentifier, for: indexPath) as! DateCell
            if(indexPath.row == 3){
                dateClcCell.imgCalnder.alpha = 1.0
                dateClcCell.lblDay.alpha = 0.0
                dateClcCell.lblDate.alpha = 0.0
            }
            else{
                dateClcCell.imgCalnder.alpha = 0.0
                dateClcCell.lblDay.alpha = 1.0
                dateClcCell.lblDate.alpha = 1.0
            }
            return dateClcCell
        }else{
            let timeClcCell: TimeCell = clcViewTime.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifier.qTimeCellIdentifier, for: indexPath) as! TimeCell
            return timeClcCell
        }
    }
}


//MARK: UICollectionView Delegate
extension BookDateTimeEventVC: UICollectionViewDelegate {
    func collectionViewDidEndMultipleSelectionInteraction(_ collectionView: UICollectionView) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == clcViewDate){
            if(indexPath.row == 3){
                
            }else{
                let cell: DateCell = collectionView.cellForItem(at: indexPath) as! DateCell
                cell.contentView.backgroundColor = UIColor.AppStatusBarColor()
                cell.lblDate.textColor = UIColor.white
                cell.lblDay.textColor = UIColor.white
            }
        }else{
            let cell: TimeCell = collectionView.cellForItem(at: indexPath) as! TimeCell
            cell.contentView.backgroundColor = UIColor.AppStatusBarColor()
            cell.lblTime.textColor = UIColor.white
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if(collectionView == clcViewDate){
            let cell: DateCell = collectionView.cellForItem(at: indexPath) as! DateCell
            cell.contentView.backgroundColor = UIColor.clear
            cell.lblDate.textColor = UIColor.AppDateLabelDefaultColor()
            cell.lblDay.textColor = UIColor.AppDayLabelDefaultColor()
        }else{
            let cell: TimeCell = collectionView.cellForItem(at: indexPath) as! TimeCell
            cell.contentView.backgroundColor = UIColor.clear
            cell.lblTime.textColor = UIColor.AppDateLabelDefaultColor()
            
        }
    }
}


//MARK: UICollectionViewDelegateFlowLayout
extension BookDateTimeEventVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == clcViewDate){
            return CGSize(width:75, height: 77)
        }else{
            return CGSize(width:81, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    
}

//MARK: Collection View Cell
class DateCell: UICollectionViewCell {
    
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var imgCalnder: UIImageView!
    
    override func awakeFromNib() {
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
    }
    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = UIColor.AppStatusBarColor()
            self.lblDate.textColor = UIColor.white
            self.lblDay.textColor = UIColor.white
        }
    }
}

//MARK: Collection View Cell
class TimeCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTime: UILabel!
    override func awakeFromNib() {
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
    }
    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = UIColor.AppStatusBarColor()
            self.lblTime.textColor = UIColor.white
            
        }
    }
}
