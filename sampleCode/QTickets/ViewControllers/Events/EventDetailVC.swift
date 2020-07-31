

import UIKit


class EventDetailVC: BaseViewController {

    
    @IBOutlet weak var bookTicket: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventPrice: UILabel!
    @IBOutlet weak var eventAddress: UILabel!
    @IBOutlet weak var logoMap: UIImageView!
    @IBOutlet weak var headingSummary: UILabel!
    @IBOutlet weak var descriptionLabelText: UILabel!
    @IBOutlet weak var heightConstraintDescLabel: NSLayoutConstraint!
    @IBOutlet weak var btnSeeMore: UIButton!
    @IBOutlet weak var lblheadingArtist: UILabel!
    @IBOutlet weak var clcView: UICollectionView!
    @IBOutlet weak var tblView: UITableView!
    
    var objEventDetailsViewModel = EventDetailsViewModel()
    var eventID = ""
    var seeMore = true
    var objEventDetailsModel :  EventDetailsModel!
    var objEventDetailsResponce = [EventDetailsResponse]()
    var popUpView = KLCPopup()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setScreenUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}


//MARK: Helper Methods
extension EventDetailVC {
    
    func setScreenUI() {
        EventDetailsVC()
        print_QT4DebugMode()
        self.tblView.register(UINib(nibName: "EventDetailCell", bundle: nil), forCellReuseIdentifier: TableViewCellIdentifier.qEventDetailCellIdentifier)
        tblView.dataSource = self
        tblView.delegate = self
    }
}


//MARK: Button Action Methods

extension EventDetailVC {
    
    @IBAction func Back(_ sender: Any) {
        print_QT4DebugMode()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func BookTikcet(_ sender: Any) {
        let storyboard = UIStoryboard(name: StoryboardName.eventBookingStoryboard, bundle: nil)
        let eventDetailVC = storyboard.instantiateViewController(identifier: ViewControllerIdentifier.qBookDateTimeEventIdentifire) as! BookDateTimeEventVC
        self.navigationController?.pushViewController(eventDetailVC, animated: true)
        
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

    @IBAction func WriteReview(_ sender: Any) {
        print_QT4DebugMode()
        
        let reviewView = Bundle.main.loadNibNamed("APReviewPopView", owner: nil, options: nil)?.first as? APReviewPopView
        reviewView!.frame = CGRect(x: 0, y: 0, width: Constants.SCREEN_WIDTH * 0.85, height: Constants.SCREEN_HEIGHT * 0.40)
        reviewView!.reviewDelegate = self
        reviewView!.initialSetUpWith()
        popUpView = KLCPopup(contentView: reviewView, showType: KLCPopupShowType(rawValue: 8)!, dismissType:KLCPopupDismissType(rawValue: 0)!, maskType: KLCPopupMaskType(rawValue: 2)!, dismissOnBackgroundTouch: true, dismissOnContentTouch: false)
        popUpView.show(atCenter: UIApplication.shared.keyWindow!.center, in: UIApplication.shared.keyWindow!)
    }
    
    @IBAction func SeeMore(_ sender: Any) {
        print_QT4DebugMode()
        
        if seeMore {
            self.seeMore = false
            self.heightConstraintDescLabel.constant = 200
            self.btnSeeMore.setTitle("Read Less", for: .normal)
        } else {
            self.seeMore = true
            self.heightConstraintDescLabel.constant = 80
            self.btnSeeMore.setTitle("Read More", for: .normal)
        }
    }


}


//MARK: Expandable Delegates
extension EventDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EventDetailCell = self.tblView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.qEventDetailCellIdentifier, for: indexPath) as! EventDetailCell
        
        switch indexPath.row {
        case 0:
            cell.lblHeading.text = "User Reviews"
            cell.downArrow.image = UIImage(named: "arrowRight")
        case 1:
            cell.lblHeading.text = "Faq's"
            cell.downArrow.image = UIImage(named: "arrowRight")
        case 2:
            cell.lblHeading.text = "Terms & Conditions"
            cell.downArrow.image = UIImage(named: "arrowRight")
        case 3:
            cell.lblHeading.text = "Event Gallery"
            cell.downArrow.image = UIImage(named: "dropSelection")
        default:
            cell.lblHeading.text = ""
        }
        return cell
    }
    
}

extension EventDetailVC: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
           let storyboard = UIStoryboard(name: StoryboardName.secondary, bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: ViewControllerIdentifier.qUserReviewIdentifier) as! ReviewVC
            vc.ids = eventID
            vc.url = APIURL.BASE_URL + APIURL.ReviewEvent
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = self.storyboard?.instantiateViewController(identifier: ViewControllerIdentifier.qFaqVCIdentifier) as! FaqVC
            //vc.faqEventsArray = self.objEventDetailsResponce[0].faqEvents ?? [FaqEvents]()
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = self.storyboard?.instantiateViewController(identifier: ViewControllerIdentifier.qTermsVCIdentifier) as! TermsVC
           // vc.termsString = self.objEventDetailsResponce[0].Terms ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("")
        }
    }
}


extension EventDetailVC {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension EventDetailVC {
    
    func EventDetailsVC(){
        print_QT4DebugMode()
        Global.showLoadingSpinner()
        objEventDetailsViewModel.APICall(url: APIURL.BASE_URL + APIURL.EVENT_DETAILS + eventID) { (responseArray) in
            Global.dismissLoadingSpinner()
            self.objEventDetailsModel = responseArray
            if(self.objEventDetailsModel.status == true){
                self.objEventDetailsResponce = self.objEventDetailsModel.responses!
                if(self.objEventDetailsResponce.count>0){
                    self.eventTitle.text = self.objEventDetailsResponce[0].eventTitle
                    self.eventDate.text = self.objEventDetailsResponce[0].eventDate
                    self.descriptionLabelText.text = self.objEventDetailsResponce[0].descriptionField
                    self.eventTime.text = ""
                    self.eventPrice.text = ""
                    self.eventAddress.text = self.objEventDetailsResponce[0].locationName
                    self.headingSummary.text = "Summary"
                    self.lblheadingArtist.text = "Artist Details"
                    self.btnSeeMore.setTitle("Read More", for: .normal)
                    self.imgView.setImage(with: self.objEventDetailsResponce[0].posterPath ?? "")
                    self.clcView.dataSource = self
                    self.clcView.delegate = self
                    self.clcView.reloadData()
                }
            }else{
                Global.showAlertWithMessage(message: self.objEventDetailsModel.message ?? "")
            }
        }
    }
    
    func timeString(time: TimeInterval) -> String {
        let hour = Int(time) / 3600
        let minute = Int(time) / 60 % 60
       // let second = Int(time) % 60

        // return formated string
        return String(format: "%02i hrs %02i mins", hour, minute)
    }
    
    
}


class ArtistCell: UICollectionViewCell {
    
    @IBOutlet weak var imgArtist: UIImageView!
    @IBOutlet weak var lblArtist: UILabel!
}


//MARK: Collection View Data Source Methods
extension EventDetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.objEventDetailsResponce[0].artistDetails?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ArtistCell = self.clcView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifier.qArtistCellIdentifier, for: indexPath) as! ArtistCell
        let dict = self.objEventDetailsResponce[0].artistDetails?[indexPath.item]
        cell.imgArtist.layer.cornerRadius = cell.imgArtist.frame.size.height/2
        cell.imgArtist.clipsToBounds = true
        cell.lblArtist.text = dict?.name ?? ""
        cell.imgArtist.setImage(with: dict?.image ?? "")
        return cell
    }
    
}

extension EventDetailVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100.0, height: 80.0)
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }
}


// MARK: APReviewPopViewDelegate Methode
extension EventDetailVC : APReviewPopViewDelegate {
    func submitButtonClickWith(ratting: String, reviewMessage: String) {
        print_QT4DebugMode()
        self.popUpView.dismiss(true)
    }
}
