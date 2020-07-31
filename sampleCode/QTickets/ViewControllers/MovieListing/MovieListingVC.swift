

import UIKit

class MovieListingVC: BaseViewController {
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var clcViewmovies: UICollectionView!
    var objMovieListViewModel = MovieListViewModel()
    var objMovieListModel : MovieListModel!
    var objMovieListResponse = [MovieListResponse]()
    var movieType = ""
    var pageNo = 1
    var type = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setScreenUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pageNo = 1
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        Global.dismissLoadingSpinner()
        setNavigationBarStyle(transparent: false, leftButton: true, rightButton: false, title: "key_movies_listing_header".localized())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    
    //MARK:- Action method
    
    @IBAction func FilterAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: ViewControllerIdentifier.qMovietFilterVC) as! MovieFilterVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalPresentationCapturesStatusBarAppearance = false
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func Detail(_ sender: Any) {
        print_QT4DebugMode()
        
        let storyboard = UIStoryboard(name: "DetailScreens", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifier.qMovieDetailVCIdentifier) as! MovieDetailVC
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK:-  segment event
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        if segmentControl.selectedSegmentIndex == 0 {
            print("Select 0")
            pageNo = 1
            movieType = "Now"
             movieListApiCall()
        } else if segmentControl.selectedSegmentIndex == 1 {
            print("Select 1")
             pageNo = 1
            movieType = "Coming"
            movieListApiCall()
        } 
    }
}

extension MovieListingVC {
    func setScreenUI() {
        movieType = "Now"
        type = "banner"
        pageNo = 1
        movieListApiCall()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        clcViewmovies.setCollectionViewLayout(layout, animated: true)
        segmentControl.addTarget(self, action: #selector(EventsListingVC.indexChanged(_:)), for: .valueChanged)
        segmentControl.setSegmentStyle()
        self.clcViewmovies.register(UINib(nibName: XIBCollectionCell.qMovieListingCell, bundle: nil), forCellWithReuseIdentifier: CollectionViewCellIdentifier.qMovieListingCellIdentifire)
        self.clcViewmovies.dataSource = self
        self.clcViewmovies.delegate = self
    }
}

//MARK: UICollectionViewSource
extension MovieListingVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objMovieListResponse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: MovieListingCVC = self.clcViewmovies.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifier.qMovieListingCellIdentifire, for: indexPath) as! MovieListingCVC
        cell.lblMovieName.text = objMovieListResponse[indexPath.row].movieName
        cell.lblIMDb.text = "IMDB \(objMovieListResponse[indexPath.row].imdbRating ?? 0)"
        cell.lblDesc.text = objMovieListResponse[indexPath.row].genres
        cell.lblPG.text = objMovieListResponse[indexPath.row].pgRating
        cell.imgMovie.setImage(with: self.objMovieListResponse[indexPath.row].poster ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "DetailScreens", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifier.qMovieDetailVCIdentifier) as! MovieDetailVC
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        vc.movieID = "\(objMovieListResponse[indexPath.row].movieId ?? "")"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            if indexPath.row == objMovieListResponse.count - 1 {  //numberofitem count
                updateNextSet()
            }
    }

    func updateNextSet(){
           pageNo = pageNo + 1
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension MovieListingVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = clcViewmovies.frame.width / 2 - lay.minimumInteritemSpacing
        
        return CGSize(width:widthPerItem-10, height:250)
    }
    
    
}

extension MovieListingVC {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


extension MovieListingVC {
    
    func movieListApiCall(){
        print_QT4DebugMode()
        Global.showLoadingSpinner()
        let MovieUrl: String = "\(APIURL.MOVIE_Listing)source=\("Mobile")&type=\(type)&movieType=\(movieType)&pageNumber=\(pageNo)"
        objMovieListViewModel.APICall(url: APIURL.BASE_URL  + MovieUrl) { (responseArray) in
            Global.dismissLoadingSpinner()
            self.objMovieListModel = responseArray
            if(self.objMovieListModel.status == true){
                self.objMovieListResponse = self.objMovieListModel.response!
                self.clcViewmovies.reloadData()
                //  print_QT4DebugModeSimpleForm(items: self.objMovieListResponse)
            }else{
                 self.objMovieListResponse = [MovieListResponse]()
                Global.showAlertWithMessage(message: self.objMovieListModel.message ?? "")
                self.clcViewmovies.reloadData()
            }
        }
    }
}
