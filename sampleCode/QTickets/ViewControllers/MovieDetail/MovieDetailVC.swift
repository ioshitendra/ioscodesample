
import youtube_ios_player_helper_swift
import UIKit
import Kingfisher
import EventKit
import AVFoundation

class MovieDetailVC: BaseViewController {
    
    //MARK: Outlets
    @IBOutlet weak var imgMovieBanner: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblRatingMovie: UILabel!
    @IBOutlet weak var lblTheatreType: UILabel!
    @IBOutlet weak var lblGenreType: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var btnShareMovie: UIButton!
    @IBOutlet weak var btnAddToCalender: UIButton!
    @IBOutlet weak var castClcView: UICollectionView!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnReadMore: UIButton!
    @IBOutlet weak var lblHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var clcViewGallery: UICollectionView!
    @IBOutlet weak var heightconstraintParentView: NSLayoutConstraint!
    @IBOutlet weak var lblcastCrewHeading: UILabel!
    @IBOutlet weak var topConstraintWritwReview: NSLayoutConstraint!
    
    private var playerView: PlayerView!
    var popUpView = KLCPopup()
    var movieID = ""
    var objMovieDetailsViewModel = MovieDetailsViewModel()
    var objTrendingViewModel = TrendingMovieViewModel()
    var objtrendingModel = TrendingStory(dict: [String: Any]())
    var objMovieDetailsModel : MovieDetailsModel!
    var objMovieDetailsResponse = [MovieDetailsResponse]()
    var shareUrl = ""
    var movieTitle = ""
    var genre = ""
    var releaseDate = ""
    var isExpended = true
    var GalleryHeight: CGFloat = 140.0
    var CastCrewHeight: CGFloat = 150.0
    var totalHeight: CGFloat = 1018.0
    var castCrewCount = 0
    //MARK: Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setScreenUI()
        self.tblView.register(UINib(nibName: "EventDetailCell", bundle: nil), forCellReuseIdentifier: TableViewCellIdentifier.qEventDetailCellIdentifier)
        self.tblView.dataSource = self
        self.tblView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension MovieDetailVC {
    
    func setScreenUI() {
        print_QT4DebugMode()
        tblView.tableFooterView = UIView()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        playerView = UINib(nibName: "PlayerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? PlayerView
        movieDetailsApiCall()
        trendingStoryAPICall()
        self.btnAddToCalender.layer.cornerRadius = 3
        self.btnShareMovie.layer.cornerRadius = 3
        self.btnReadMore.isHidden = true
    }
    
    private func addPlayerView(){
           self.view.addSubview(playerView)
           playerView.frame = CGRect(x: 0, y: 0, width: Constants.SCREEN_WIDTH, height: Constants.SCREEN_HEIGHT)
           playerView.playerDelegate = self
           playerView.autoresizingMask = .flexibleWidth
       }
    
    func getLabelHeight(text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let lbl = UILabel(frame: .zero)
        lbl.frame.size.width = width
        lbl.font = font
        lbl.numberOfLines = 0
        lbl.text = text
        lbl.sizeToFit()

        return lbl.frame.size.height
    }
    
    func addEventToCalendar(title: String, description: String?, startDate: Date, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        
        let eventStore = EKEventStore()
        DispatchQueue.main.async {
            eventStore.requestAccess(to: .event, completion: { (granted, error) in
                if (granted) && (error == nil) {
                    let event = EKEvent(eventStore: eventStore)
                    event.title = title
                    event.startDate = startDate
                    event.isAllDay = true
                    // event.endDate = endDate
                    event.notes = description
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    do {
                        try eventStore.save(event, span: .thisEvent)
                    } catch let e as NSError {
                        completion?(false, e)
                        return
                    }
                    
                    completion?(true, nil)
                } else {
                    completion?(false, error as NSError?)
                }
            })
        }
    }
}


//MARK: Button Action Methods
extension MovieDetailVC {
    
    @IBAction func PlayAction(_ sender: Any) {
        if(self.objMovieDetailsResponse.count>0){
        let videoURL = self.objMovieDetailsResponse[0].trailerUrl ?? ""
            if(videoURL == ""){
                Global.showAlertWithMessage(message: "oops Video found")
                return
            }
        playerView.videoId = videoURL.youtubeID ?? ""
        self.addPlayerView()
        }
      }
      
    @IBAction func Back(_ sender: Any) {
        print_QT4DebugMode()
        self.navigationController?.popViewController(animated: true)
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
    
    @IBAction func ReadMore(_ sender: Any) {
        
    }
    
    @IBAction func AddTocalendar(_ sender: Any) {
        print_QT4DebugMode()
        /*
        let df = DateFormatter()
        let date: Date = df.date(from: releaseDate) ?? Date()
        self.addEventToCalendar(title: self.movieTitle, description: self.genre, startDate: date) { (check, error) in
            if error != nil {
                if check {
                    Global.showAlertWithMessage(message: "Event added to calendar")
                } else {
                    Global.showAlertWithMessage(message: "Unable to add event to calendar")
                }
            } else {
                Global.showAlertWithMessage(message: "Unable to add event to calendar")
            }
        }
        */
    }
    
    @IBAction func ShareThisMovie(_ sender: Any) {
        print_QT4DebugMode()
        
        let items = [URL(string: shareUrl)!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    @IBAction func BookTickets(_ sender: Any) {
        print_QT4DebugMode()
        let storyboard = UIStoryboard(name: "EventBooking", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifier.qMovieDataCinemaSelectionIndetifire) as! MovieDateCinemaSelectionVC
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: API Calling Methods
extension MovieDetailVC {
    
    func movieDetailsApiCall() {
        print_QT4DebugMode()
        
        Global.showLoadingSpinner()
        objMovieDetailsViewModel.APICall(url: APIURL.BASE_URL + APIURL.Movies_MovieDetail + movieID) { (responseArray) in
            Global.dismissLoadingSpinner()
            self.objMovieDetailsModel = responseArray
            if(self.objMovieDetailsModel.status == true){
                self.objMovieDetailsResponse = self.objMovieDetailsModel.responses!
                if(self.objMovieDetailsResponse.count > 0){
                    self.movieTitle = self.objMovieDetailsResponse[0].movieName ?? ""
                    self.lblMovieName.text = self.movieTitle
                    self.lblRatingMovie.text = "\(self.objMovieDetailsResponse[0].imdbRating ?? 0)"
                    self.genre = self.objMovieDetailsResponse[0].genres ?? ""
                    self.lblGenreType.text = self.genre
                    self.releaseDate = self.objMovieDetailsResponse[0].releaseDate ?? ""
                    self.lblTheatreType.text = self.objMovieDetailsResponse[0].experience
                    self.lblLanguage.text = self.objMovieDetailsResponse[0].language
                    self.lblDuration.text = "\(self.objMovieDetailsResponse[0].duration ?? 0) mins"
                    let movieDesc: String = (self.objMovieDetailsResponse[0].descriptionField ?? "").replacingOccurrences(of: "\n", with: "")
                    if self.getLabelHeight(text: movieDesc, width: Constants.SCREEN_WIDTH - 41, font: UIFont.systemFont(ofSize: 12)) < 30.0 {
                        self.btnReadMore.isHidden = true
                    } else {
                        self.btnReadMore.isHidden = false
                    }
                    self.lblDesc.text = movieDesc
                    self.imgMovieBanner.setImage(with: self.objMovieDetailsResponse[0].poster ?? "")
                    self.shareUrl = self.objMovieDetailsResponse[0].movieLinkToShare ?? ""
                    self.castCrewCount = self.objMovieDetailsResponse[0].castCrew?.count ?? 0
                    if self.castCrewCount > 0 {
                        self.castClcView.dataSource = self
                        self.castClcView.delegate = self
                        self.castClcView.reloadData()
                    } else {
                        self.castClcView.isHidden = true
                        self.lblcastCrewHeading.isHidden = true
                        self.topConstraintWritwReview.constant = 40
                        self.heightconstraintParentView.constant = self.totalHeight - self.CastCrewHeight
                    }
                }
            } else {
                Global.showAlertWithMessage(message: self.objMovieDetailsModel.message ?? "")
            }
        }
    }
    
    func trendingStoryAPICall() {
        print_QT4DebugMode()
        
        Global.showLoadingSpinner(message: "Loading", sender: self)
        objTrendingViewModel.APICall(url: APIURL.BASE_URL + APIURL.TrendingMovie) { (responseArray) in
            Global.dismissLoadingSpinner()
            self.objtrendingModel = responseArray
            Global.dismissLoadingSpinner(sender: self)
            self.clcViewGallery.dataSource = self
            self.clcViewGallery.reloadData()
        }
    }
}

//MARK: Collection View Data Source Methods
extension MovieDetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == castClcView {
            return self.objMovieDetailsResponse[0].castCrew?.count ?? 0
        } else {
            return self.objtrendingModel.response?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == castClcView {
            let cell: CastCell = self.castClcView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifier.qCastCellIdentifier, for: indexPath) as! CastCell
            let dict = self.objMovieDetailsResponse[0].castCrew?[indexPath.item]
            cell.imgArtist.layer.cornerRadius = cell.imgArtist.frame.size.height/2
            cell.imgArtist.clipsToBounds = true
            cell.nameArtist.text = dict?.castName ?? ""
            cell.imgArtist.setImage(with: dict?.castImage ?? "")
            return cell
        } else {
            let cell: MovieGalleryCell = self.clcViewGallery.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifier.qMovieGalleryCellIdentifier, for: indexPath) as! MovieGalleryCell
            cell.imgView.layer.cornerRadius = 5
            cell.imgView.clipsToBounds = true
            let strVideo = self.objtrendingModel.response?[indexPath.item].stroyVideo ?? ""
            if strVideo != "" {
                cell.playIcon.isHidden = false
                let youTubeId = strVideo.youtubeID
                cell.imgView.setImage(with: "http://img.youtube.com/vi/\(youTubeId ?? "")/1.jpg")
            } else {
                cell.playIcon.isHidden = true
                cell.imgView.image = UIImage(named: "moviebanner")
            }
            return cell
        }
    }
    
}

extension MovieDetailVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100.0, height: 80.0)
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }
}


extension MovieDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EventDetailCell = self.tblView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.qEventDetailCellIdentifier, for: indexPath) as! EventDetailCell
        
        switch indexPath.row {
        case 0:
            cell.lblHeading.text = "User Reviews"
            cell.lblHeading.textColor = UIColor.ApptabelHederlcellColor()
            cell.downArrow.image = UIImage(named: "arrowRight")
        case 1:
            cell.lblHeading.text = "Faq's"
            cell.lblHeading.textColor = UIColor.ApptabelHederlcellColor()
            cell.downArrow.image = UIImage(named: "arrowRight")
        case 2:
            cell.lblHeading.text = "Terms & Conditions"
            cell.lblHeading.textColor = UIColor.ApptabelHederlcellColor()
            cell.downArrow.image = UIImage(named: "arrowRight")
        case 3:
            cell.lblHeading.text = "Trending Stories"
            cell.lblHeading.textColor = UIColor.trendingDarkColor()
            cell.downArrow.image = UIImage(named: "arrowUp")
        default:
            cell.lblHeading.text = ""
        }
        return cell
    }
    
}

extension MovieDetailVC: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell: EventDetailCell = tableView.cellForRow(at: indexPath) as! EventDetailCell

        switch indexPath.row {
        case 0:
             let storyboard = UIStoryboard(name: StoryboardName.secondary, bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: ViewControllerIdentifier.qUserReviewIdentifier) as! ReviewVC
            vc.ids = movieID
            vc.url = APIURL.BASE_URL + APIURL.ReviewMoive
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = self.storyboard?.instantiateViewController(identifier: ViewControllerIdentifier.qFaqVCIdentifier) as! FaqVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = self.storyboard?.instantiateViewController(identifier: ViewControllerIdentifier.qTermsVCIdentifier) as! TermsVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            print("")
            if isExpended {
                self.isExpended = false
                cell.downArrow.image = UIImage(named: "dropSelection")
                cell.lblHeading.textColor = UIColor.ApptabelHederlcellColor()
                self.clcViewGallery.isHidden = true
                if castCrewCount > 0 {
                self.heightconstraintParentView.constant = totalHeight - GalleryHeight
                } else {
                    if (totalHeight - GalleryHeight - CastCrewHeight) < Constants.SCREEN_HEIGHT {
                        self.heightconstraintParentView.constant = Constants.SCREEN_HEIGHT
                    } else {
                        self.heightconstraintParentView.constant = totalHeight - GalleryHeight - CastCrewHeight
                    }
                }
            } else {
                self.isExpended = true
                cell.downArrow.image = UIImage(named: "arrowUp")
                cell.lblHeading.textColor = UIColor.trendingDarkColor()
                self.clcViewGallery.isHidden = false
                if castCrewCount > 0 {
                    self.heightconstraintParentView.constant = totalHeight
                } else {
                    self.heightconstraintParentView.constant = totalHeight - CastCrewHeight
                }
            }
        default:
            print("")
        }
    }
}


class CastCell: UICollectionViewCell {
    
    @IBOutlet weak var imgArtist: UIImageView!
    @IBOutlet weak var nameArtist: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}

class MovieGalleryCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var playIcon: UIImageView!
}


extension UIImageView {
    func setImage(with urlString: String){
        let tempstring = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let url = URL.init(string: tempstring ?? "") else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        var kf = self.kf
        kf.indicatorType = .activity
        self.kf.setImage(with: resource)
    }
}


extension MovieDetailVC: PlayerControls {
    
    func closePlayer() {
        self.playerView.removeFromSuperview()
    }
}

extension String {
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"

        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)

        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }

        return (self as NSString).substring(with: result.range)
    }
}



// MARK: APReviewPopViewDelegate Methode
extension MovieDetailVC : APReviewPopViewDelegate {
    func submitButtonClickWith(ratting: String, reviewMessage: String) {
        print_QT4DebugMode()
        self.popUpView.dismiss(true)
    }
}
