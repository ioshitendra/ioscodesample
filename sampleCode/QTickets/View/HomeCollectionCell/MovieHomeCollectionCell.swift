

import UIKit
import Localize_Swift
import MarqueeLabel


class MovieHomeCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblTitle: MarqueeLabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var imgStar: UIImageView!
    @IBOutlet weak var widthConstraintImgStar: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblTitle.textAlignment = .left
        imgView.layer.cornerRadius = 5
        imgView.clipsToBounds = true
    }
    
    var movieData: HomeGenericData! {
        didSet {
            self.imgView.setImage(with: movieData.poster ?? "")
            self.lblTitle.text = movieData.movieName ?? ""
            self.lblGenre.text = movieData.genres ?? ""
            let imdbrating: Int = movieData.imdbRating ?? 0
            if imdbrating > 0 {
                self.lblRating.text = "\(movieData.imdbRating ?? 0)  |  \(movieData.pgRating ?? "")"
            } else {
                self.lblRating.text = "\(movieData.pgRating ?? "")"
            }
            self.imgStar.isHidden = false
            self.widthConstraintImgStar.constant = 8
        }
    }
    
    var eventsData: HomeGenericData! {
        didSet {
            self.imgView.setImage(with: eventsData.posterPath ?? "")
            self.lblTitle.text = eventsData.eventTitle ?? ""
            self.lblGenre.text = eventsData.eventDate ?? ""
            self.lblRating.text = eventsData.locationName ?? ""
            self.imgStar.isHidden = true
            self.widthConstraintImgStar.constant = 0
        }
    }
    
}
