
import UIKit
import Localize_Swift

class EventsListingVC: BaseViewController {

    var eventListModels = EventListViewModel()
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var objEventListModel : EventListModel!
    var objEventListResponse = [EventListResponse]()
    var strcategoryId = ""
    var eventFilter = ""
    @IBOutlet weak var clcViewEvents: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setScreenUI()
        EventListApiCall()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        setNavigationBarStyle(transparent: false, leftButton: true, rightButton: true, title: "key_events_listing_header".localized())
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK:- Action method
    
    @IBAction func Filter(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(identifier: ViewControllerIdentifier.qEventFilterVC) as! EventFilterVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK:-  segment event
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        if segmentControl.selectedSegmentIndex == 0 {
            eventFilter = "all"
             EventListApiCall()
        } else if segmentControl.selectedSegmentIndex == 1 {
             eventFilter = "thisweek"
             EventListApiCall()
        } else if segmentControl.selectedSegmentIndex == 2 {
             eventFilter = "thismonth"
             EventListApiCall()
        }
    }
}


//MARK: SetScreenUI
extension EventsListingVC {
    
    func setScreenUI() {
        print_QT4DebugMode()
        eventFilter = "all"
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        clcViewEvents.setCollectionViewLayout(layout, animated: true)
        segmentControl.addTarget(self, action: #selector(EventsListingVC.indexChanged(_:)), for: .valueChanged)
        segmentControl.setSegmentStyle()
        self.clcViewEvents.register(UINib(nibName: XIBCollectionCell.qEventsListingCell, bundle: nil), forCellWithReuseIdentifier: CollectionViewCellIdentifier.qEventsListingCellIdentifier)
        self.clcViewEvents.dataSource = self
        self.clcViewEvents.delegate = self
        self.clcViewEvents.reloadData()
    }
    
}



//MARK: UICollectionViewSource
extension EventsListingVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objEventListResponse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: EventsListingCell = self.clcViewEvents.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifier.qEventsListingCellIdentifier, for: indexPath) as! EventsListingCell
       // cell.imgView.kf.setImage(with: self.eventListData.)
        cell.eventName.text =  self.objEventListResponse[indexPath.row].eventTitle
        cell.eventCategory.text = self.objEventListResponse[indexPath.row].eventDate
        cell.eventPrice.text = self.objEventListResponse[indexPath.row].locationName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: StoryboardName.detailStoryboard, bundle: nil)
        let eventDetailVC = storyboard.instantiateViewController(identifier: ViewControllerIdentifier.qEventDetailVCIdentifier) as! EventDetailVC
        eventDetailVC.eventID = self.objEventListResponse[indexPath.row].eventId ?? ""
        self.navigationController?.pushViewController(eventDetailVC, animated: true)
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension EventsListingVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = clcViewEvents.frame.width / 2 - lay.minimumInteritemSpacing
        
        return CGSize(width:widthPerItem-10, height:250)
    }
    
    
}

extension EventsListingVC {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension EventsListingVC {
    
    func EventListApiCall(){
        Global.showLoadingSpinner()
           print_QT4DebugMode()
          let Url: String = "\(APIURL.BASE_URL + APIURL.EVENT_LISTING)source=\("mobile")&categoryId=\(strcategoryId )&type=listing&eventFilter=\(eventFilter)"
           eventListModels.APICall(url: Url) { (responseArray) in
            Global.dismissLoadingSpinner()
            self.objEventListModel = responseArray
             if(self.objEventListModel.status == true){
                self.objEventListResponse = self.objEventListModel.response!
                self.clcViewEvents.reloadData()
                //  print_QT4DebugModeSimpleForm(items: self.objMovieListResponse)
             }else{
                self.objEventListResponse = [EventListResponse]()
                Global.showAlertWithMessage(message: self.objEventListModel.message ?? "")
                self.clcViewEvents.reloadData()
            }
           }
       }
}

extension UISegmentedControl {
func setSegmentStyle() {
    setBackgroundImage(imageWithColor(color: UIColor.white), for: .normal, barMetrics: .default)
    setBackgroundImage(imageWithColor(color: UIColor.init(hex: "0B1036")), for: .selected, barMetrics: .default)
    setDividerImage(imageWithColor(color: UIColor.lightGray), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)

     let segAttributes: NSDictionary = [
        NSAttributedString.Key.foregroundColor: UIColor.white,
       
        ]

    setTitleTextAttributes((segAttributes as [NSObject : AnyObject] as [NSObject : AnyObject] as! [NSAttributedString.Key : Any]), for: UIControl.State.selected)
    self.layer.borderWidth = 1.0
    self.layer.cornerRadius = 5.0
    self.layer.borderColor = UIColor.lightGray.cgColor
    self.layer.masksToBounds = true
    }

    // create a 1x1 image with this color
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }
}
