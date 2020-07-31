

import UIKit
import DropDown
class MovieDateCVC: UICollectionViewCell {
    
    @IBOutlet weak var imgCal: UIImageView!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var viewDateSelection: UIView!
    var intIndex: Int?
    override var isSelected: Bool {
        didSet {
            if isSelected {
                //check arrary last count
                if(intIndex != 3){
                self.viewDateSelection.backgroundColor = UIColor.AppStatusBarColor()
                self.lblDate.textColor = UIColor.white
                self.lblDay.textColor = UIColor.white
                }
            } else {
                self.viewDateSelection.backgroundColor = UIColor.white
                self.lblDate.textColor = UIColor.ApptabelHederlcellColor()
                self.lblDay.textColor = UIColor.ApptabelHederlcellColor()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.viewDateSelection.layer.borderWidth = 1.0
        self.viewDateSelection.layer.borderColor = UIColor.ApptabelHederlcellColor().cgColor
        self.viewDateSelection.layer.cornerRadius = 3.0
        self.viewDateSelection.clipsToBounds = true
    }
}

struct EventDate {
    var title : String!
    var status : Bool!
    
}
class MovieDateCinemaSelectionVC: BaseViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblRatingMovie: UILabel!
    @IBOutlet weak var lblTheatreType: UILabel!
    @IBOutlet weak var lblGenreType: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var btn3DMovie: UIButton!
    @IBOutlet weak var btnLanguage: UIButton!
    @IBOutlet weak var clcMovieDate: UICollectionView!
    @IBOutlet weak var tblCinema: UITableView!
    @IBOutlet weak var tblHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var lblthreeD: UILabel!
    @IBOutlet weak var lblLnguage: UILabel!
    public var displayDate = NSDate()
    var weeks = 0
    var arrayDate = [EventDate]()
    lazy var dateFormatter: DateFormatter = {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    let languagedropdown = DropDown()
    let threeDdropdown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.languagedropdown,
            self.threeDdropdown
           
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setScreenUI()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
          self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
//MARK: SetScreenUI
extension MovieDateCinemaSelectionVC {
    
    func setScreenUI() {
        print_QT4DebugMode()
        lanngugefill()
        threeDfill()
        setCalendar()
        tblCinema.tableFooterView = UIView()
        self.lblMovieName.text = "Birds Of Prey"
        self.lblRatingMovie.text = "8.5"
        self.lblGenreType.text = "Action, Adventure, Crime"
        self.lblTheatreType.text = "IMAX      IMAX  2D     IMAX  3D"
        self.lblLanguage.text = "English"
        self.lblDuration.text = "1 hrs 51 mins"
        self.btnLanguage.layer.cornerRadius = 3
        self.btn3DMovie.layer.cornerRadius = 3
        clcMovieDate.delegate = self
        clcMovieDate.dataSource = self
        tblCinema.delegate = self
        tblCinema.dataSource = self
        tblHeightConstant.constant = 1050
    }
}

//MARK: Button Action Methods
extension MovieDateCinemaSelectionVC {
    
    @IBAction func Back(_ sender: Any) {
        print_QT4DebugMode()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func LanguageAction(_ sender: Any) {
        languagedropdown.show()
    }
    
    @IBAction func DAction(_ sender: Any) {
        threeDdropdown.show()
    }
    
    @IBAction func SelectSeat(_ sender: Any) {
        let storyboard = UIStoryboard(name: "EventBooking", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifier.qMoviewSeatLaout) as! MovieSeatLaoutVC
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
       }
    
   
}

extension MovieDateCinemaSelectionVC {
    
    //MARK:- Custom Calender Function
    
    func setCalendar() {
        let cal = Calendar.current
        let components = (cal as NSCalendar).components([.month, .day,.weekday,.year], from: displayDate as Date)
        let year =  components.year
        let month = components.month
        let months = dateFormatter.monthSymbols
        _ = (months![month!-1])
        
        let weekRange = (cal as NSCalendar).range(of: .weekOfMonth, in: .month, for: displayDate as Date)
        
        weeks = weekRange.length
        
        let totalMonthList = weeks * 7
        var dates = [Date]()
        var firstDate = dateFormatter.date(from: "\(year!)-\(month!)-1")!
        let componentsFromFirstDate = (cal as NSCalendar).components([.month, .day,.weekday,.year], from: firstDate)
        firstDate = (cal as NSCalendar).date(byAdding: [.day], value: -(componentsFromFirstDate.weekday!-1), to: firstDate, options: [])!
        for _ in 1 ... totalMonthList {
            
            dates.append(firstDate)
            firstDate = (cal as NSCalendar).date(byAdding: [.day], value: +1, to: firstDate, options: [])!
            print("Date is :---",firstDate.DatewithMonthDayWeek)
            let obj = EventDate(title: firstDate.DatewithMonthDayWeek, status: false)
            self.arrayDate.append(obj)
        }
        
        //End calender
        
    }
}
extension MovieDateCinemaSelectionVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.row == 3){
        self.performSegue(withIdentifier: "gotoDatePicker", sender: self)
        }
    }
}

extension MovieDateCinemaSelectionVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = clcMovieDate.dequeueReusableCell(withReuseIdentifier: "MovieDateCVC", for: indexPath) as! MovieDateCVC
        
        // cell.lbl.text = getShortDay(val: self.dateArray[indexPath.row].weekday ?? "")
        cell.intIndex = indexPath.row
        if(indexPath.row == 3){
            
            cell.isSelected = false
            cell.imgCal.isHidden = false
            cell.lblDate.isHidden = true
            cell.lblDay.isHidden = true
        }else{
            cell.imgCal.isHidden = true
            cell.lblDate.isHidden = false
            cell.lblDay.isHidden = false
        }
        return cell
    }
    
}

extension MovieDateCinemaSelectionVC :UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 90, height: 85)
    }
    
}

extension MovieDateCinemaSelectionVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblCinema.dequeueReusableCell(withIdentifier: "MovieCinemaTVC", for: indexPath) as! MovieCinemaTVC
        if(indexPath.row == 0){
            cell.lbl.text = "Flik Cinemas, Al Khor Mall"
        }else if(indexPath.row == 1){
            cell.lbl.text = "Novo Cinemas, Mall of Qatar"
        }else if(indexPath.row == 2){
            cell.lbl.text = "Village Mall Theatre"
        }else if(indexPath.row == 3){
            cell.lbl.text = "Roxy Cinemas"
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    
}
extension MovieDateCinemaSelectionVC : UITableViewDelegate{
    
}

extension MovieDateCinemaSelectionVC {
    
    func lanngugefill() {
        languagedropdown.anchorView = btnLanguage
       
        languagedropdown.bottomOffset = CGPoint(x: 0, y: languagedropdown.bounds.height+24)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        languagedropdown.dataSource = [
            "Arabic",
            "English",
            "Malayalam"
           
        ]
        
        // Action triggered on selection
        languagedropdown.selectionAction = { [weak self] (index, item) in
            self?.lblLnguage.text = item
        }
        
     
    }
    
    func threeDfill() {
           threeDdropdown.anchorView = btn3DMovie
           threeDdropdown.bottomOffset = CGPoint(x: 0, y: threeDdropdown.bounds.height+24)
           
           // You can also use localizationKeysDataSource instead. Check the docs.
           threeDdropdown.dataSource = [
               "2D",
               "3D",
               "Imax 2D",
               "Mx 4D"
              
           ]
           
           // Action triggered on selection
        
           threeDdropdown.selectionAction = { [weak self] (index, item) in
            self?.lblthreeD.text = item
           }
           
        
       }
}
