

import UIKit

class MovieListingCVC: UICollectionViewCell {
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblPG: UILabel!
    @IBOutlet weak var lblIMDb: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgMovie.layer.cornerRadius = 6
    }

}
