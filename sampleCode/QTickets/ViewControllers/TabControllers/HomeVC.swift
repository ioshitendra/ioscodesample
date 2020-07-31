

import UIKit
import ImageSlideshow
import SwiftyJSON
import Alamofire
import Kingfisher
import DropDown

//Class for Home Screen
class HomeVC: BaseViewController {

    @IBOutlet weak var logoHeaderView: UIView!
    @IBOutlet weak var lblHeaderUsername: UILabel!
    @IBOutlet weak var contentViewHeader: UIView!
    @IBOutlet weak var tblViewCategory: UITableView!
    @IBOutlet weak var heightConstraintContentView: NSLayoutConstraint!
    @IBOutlet weak var lblSubHeader: UILabel!
    @IBOutlet weak var scrlView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnCuntryDropDown: UIButton!
    @IBOutlet weak var slideshow: ImageSlideshow!
    
    var homeCountryListModels = HomeCountryListViewModel()
    var homeDataViewModels = HomeMoviesEventsViewModel()
    var imagesArray = [InputSource]()
    var imageUrlArray = [String]()
    var headingArray = [String]()
    var homeDataObj = HomeData(dict: [String: Any]())
    var homeCountryListData = [HomeCountryListResponse]()
    var storedOffsets = [Int: CGFloat]()
    var userName = String()
    var CountryData = [String]()
    let chooseArticleDropDown = DropDown()
    
    lazy var dropDowns: [DropDown] = {
        return [self.chooseArticleDropDown]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetScreenUI()
        HomePageAPICalls()
        CountryListApiCall()
        customizeDropDown()
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .any }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.userName = Constants.APP_DELEGATE.user != nil ? Constants.APP_DELEGATE.user.name ?? "" : ""
        if userName != "" {
            self.lblHeaderUsername.text = "key_hey".localized() + userName + " !"
        } else {
            self.lblHeaderUsername.text = "key_hey".localized()
        }
         self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK:- ACTION METHOD
    
    @IBAction func CountryDropDownAction(_ sender: Any) {
        chooseArticleDropDown.show()
    }
}


extension HomeVC {
    
//MARK: Function For Setting Up Screen UI Elements
    func SetScreenUI() {
        contentViewHeader.backgroundColor = UIColor.HeaderScrollViewColor()
        self.logoHeaderView.backgroundColor = UIColor.AppStatusBarColor()
        self.lblSubHeader.text = "key_subheader_home".localized()
        self.pageControl.currentPageIndicatorTintColor = UIColor.AppScrollIndicatorColor()
        self.pageControl.isHidden = true
        self.scrlView.backgroundColor = UIColor.HeaderScrollViewColor()
    }
  
//MARK: Setting Up Top Header categories
    func setHeading() {
        print_QT4DebugMode()
        
        for i in 1...headingArray.count {
            let itemButton = UIButton()
            itemButton.frame = CGRect(x: 20.0 + CGFloat(i - 1) * Constants.SCREEN_WIDTH / 4, y: 10, width: Constants.SCREEN_WIDTH / 4, height: 50)
            itemButton.titleLabel?.font = FontHelper.MontserratLightFontWithSize(size: 16)
            itemButton.titleLabel?.textColor = UIColor.white
            itemButton.contentMode = .scaleAspectFit
            itemButton.tag = i
            itemButton.setTitle(self.headingArray[i-1], for: .normal)
            itemButton.sizeToFit()
            itemButton.addTarget(self, action: #selector(headerCategoryClick(_:)), for: .touchUpInside)
            self.scrlView.addSubview(itemButton)
        }
        self.scrlView.contentSize.width = CGFloat(93*headingArray.count)
    }
}


//MARK: Helper Functions
extension HomeVC {
    
    // Function to navigate to Event Listing Page
    func moveToEventDetail(strCatId: String) {
        print_QT4DebugMode()
        
        let storyboard = UIStoryboard(name: StoryboardName.secondary, bundle: nil)
        let eventListingVC = storyboard.instantiateViewController(identifier: ViewControllerIdentifier.qEventsListingVCIdentifier) as! EventsListingVC
        eventListingVC.strcategoryId = "C2Ew01Lvk0m0UWI"
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.pushViewController(eventListingVC, animated: true)
    }
    
    func moveToMovieDetail() {
        print_QT4DebugMode()
        
        let storyboard = UIStoryboard(name: StoryboardName.secondary, bundle: nil)
        let movieListingVC = storyboard.instantiateViewController(identifier: ViewControllerIdentifier.qMovieListingVCIdentifier) as! MovieListingVC
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.pushViewController(movieListingVC, animated: true)
    }
    
    //MARK: Function for performing Top Header Category Actions
    @objc func headerCategoryClick(_ sender: UIButton) {
        print_QT4DebugMode()
        print_QT4DebugModeSimpleForm(items: sender.tag)
        
        switch sender.tag {
        case 1:
            self.moveToMovieDetail()
        case 2:
            self.moveToEventDetail(strCatId: "")
        default:
            print_QT4DebugMode()
        }
    }
    
    //MARK: Function for dropdown
    func customizeDropDown() {
        let appearance = DropDown.appearance()
        
        appearance.cellHeight = 60
        appearance.backgroundColor = UIColor(white: 1, alpha: 1)
        appearance.selectionBackgroundColor = UIColor(red: 0.6494, green: 0.8155, blue: 1.0, alpha: 0.2)
        appearance.cornerRadius = 10
        appearance.shadowColor = UIColor(white: 0.6, alpha: 1)
        appearance.shadowOpacity = 0.9
        appearance.shadowRadius = 25
        appearance.animationduration = 0.25
        appearance.textColor = .darkGray
        appearance.setupMaskedCorners([.layerMaxXMaxYCorner, .layerMinXMaxYCorner])
        dropDowns.forEach {
            $0.cellNib = UINib(nibName: "MyCell", bundle: nil)
            $0.customCellConfiguration = { (index, item, cell) -> Void in
                guard let cell = cell as? MyCell else { return }
                cell.logoImageView.image = UIImage(named: "QatarFlag")
            }
        }
    }
    
    func setupChooseArticleDropDown(arrayData: [String]) {
        chooseArticleDropDown.anchorView = btnCuntryDropDown
        chooseArticleDropDown.bottomOffset = CGPoint(x: 0, y: btnCuntryDropDown.bounds.height)
        chooseArticleDropDown.dataSource = arrayData
        chooseArticleDropDown.selectionAction = { [weak self] (index, item) in
            let countryId = self!.homeCountryListData[index].id
            Constants.APP_USER_DEFAULTS.set("\(countryId ?? 0)", forKey: "CountryId")
        }
    }
}

//MARK: API Calling Methods
extension HomeVC {
    
    func HomePageAPICalls() {
        print_QT4DebugMode()
        Global.showLoadingSpinner()
        
        homeDataViewModels.APICall(url: APIURL.BASE_URL + APIURL.HOME_DATA) { (responseArray) in
            
            self.homeDataObj = responseArray
            self.headingArray.removeAll()
            for obj in self.homeDataObj.response ?? [ResponseHome](){
                self.headingArray.append(obj.heading ?? "")
            }
         //   self.imageUrlArray.removeAll()
          //  self.imagesArray.removeAll()
            /*
            for obj in self.homeDataObj.response?.movieBanner ?? [BannerHomeMovie]() {
                self.imageUrlArray.append(obj.poster ?? "")
            }
            for obj in self.homeDataObj.response?.eventbanner ?? [BannerHomeEvents]() {
                self.imageUrlArray.append(obj.posterPath ?? "")
            }
            for obj in self.imageUrlArray {
                let alamofireSource = AlamofireSource(urlString: obj.replacingOccurrences(of: " ", with: "") )!
                self.imagesArray.append(alamofireSource)
            }
            */
            self.slideshow.setImageInputs(self.imagesArray)
            self.pageControl.isHidden = false
            self.pageControl.numberOfPages = self.imageUrlArray.count
            self.pageControl.currentPageIndicatorTintColor = UIColor.red
            self.pageControl.pageIndicatorTintColor = UIColor.white
            self.slideshow.pageIndicator = self.pageControl
            self.slideshow.slideshowInterval = 4.0
            self.slideshow.contentScaleMode = .scaleToFill
            Global.dismissLoadingSpinner()
            self.setHeading()
            self.heightConstraintContentView.constant = CGFloat(self.headingArray.count * 285) + 390 - (Constants.SCREEN_HEIGHT)
            self.tblViewCategory.register(UINib(nibName: XIBTableCell.qHomeTableCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifier.qHomeTableCellIdentifier)
            self.tblViewCategory.dataSource = self
            self.tblViewCategory.delegate = self
            self.tblViewCategory.reloadData()
        }
    }
    
    func CountryListApiCall() {
        print_QT4DebugMode()
        Global.showLoadingSpinner()
        homeCountryListModels.APICall(url: APIURL.BASE_URL + APIURL.COUNTRYLIST) { (responseArray) in
            self.homeCountryListData = responseArray
            for data in self.homeCountryListData {
                self.CountryData.append(data.countryName ?? "Qatar")
                let localResult = Global.fetchData()
                if(localResult?.count == 0 || localResult == nil){
                    Global.shared.openDatabse(combinedCode: data.combinedCode!, countryAlpha2Code: data.countryAlpha2Code!, countryAlpha3Code: data.countryAlpha3Code!, countryName: data.countryName!, id:"\(data.id ?? 0)")
                }
            }
            self.setupChooseArticleDropDown(arrayData: self.CountryData)
            Global.dismissLoadingSpinner()
        }
    }
}


//MARK: UITableViewDelegate Methods
extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeDataObj.response?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: HomeMoviesTableCell = tblViewCategory.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.qHomeTableCellIdentifier, for: indexPath) as! HomeMoviesTableCell
        cell.moviesData = self.homeDataObj.response?[indexPath.row].data ?? [HomeGenericData]()
        cell.lblCategory.text = self.headingArray[indexPath.row]
        cell.btnSeeAll.setTitle("View All (\(self.homeDataObj.response?[indexPath.row].count ?? 0))", for: .normal)
        cell.btnSeeAll.tag = indexPath.row + 1
        cell.btnSeeAll.addTarget(self, action: #selector(headerCategoryClick(_:)), for: .touchUpInside)
        cell.movieCollectionView.tag = indexPath.row
        cell.movieCollectionView.reloadData()
        return cell
    }
}


//MARK: UITableViewDelegate Methods
extension HomeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
}

class BannerCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        self.containerView.layer.cornerRadius = 14
        self.containerView.clipsToBounds = true
    }
}

extension HomeVC {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
