

import UIKit


class HomeMoviesTableCell: UITableViewCell {
    
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var btnSeeAll: UIButton!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    // the closure, () -> () means take no input and return void (nothing)
    // it is wrapped in another parentheses outside in order to make the closure optional
    var seeAllButtonAction : (() -> ())?
    var arrayData = [HomeGenericData]()
    
    override func awakeFromNib() {
        
        btnSeeAll.setTitle("key_view_all".localized(), for: .normal)
        self.movieCollectionView.register(UINib(nibName: XIBCollectionCell.qHomeCollectionCell, bundle: nil), forCellWithReuseIdentifier: CollectionViewCellIdentifier.qHomeCollectionCellId)
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
    }
    
    var moviesData: [HomeGenericData]! {
        didSet {
            self.arrayData = moviesData
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func subscribeButtonTapped(_ sender: UIButton){
      seeAllButtonAction?()
    }
}


//MARK: UICollectionView Data Source
extension HomeMoviesTableCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let movieClcCell: MovieHomeCollectionCell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifier.qHomeCollectionCellId, for: indexPath) as! MovieHomeCollectionCell
        switch movieCollectionView.tag {
        case 0:
            movieClcCell.movieData = arrayData[indexPath.item]
        case 1:
            movieClcCell.eventsData = arrayData[indexPath.item]
        default:
            print_QT4DebugModeSimpleForm(items: "")
        }
        return movieClcCell
    }
    
}


//MARK: UICollectionView Delegate
extension HomeMoviesTableCell: UICollectionViewDelegate {
    
}


//MARK: UICollectionViewDelegateFlowLayout
extension HomeMoviesTableCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:150, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 5.0)
    }

}

