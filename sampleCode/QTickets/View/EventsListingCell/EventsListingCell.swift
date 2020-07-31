

import UIKit

class EventsListingCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventCategory: UILabel!
    @IBOutlet weak var eventPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.imgView.layer.cornerRadius = 8
        self.imgView.clipsToBounds = true
//        self.eventName.text = "Desert Safari"
//        self.eventCategory.text = "Al- Meera, Al- Dhakira"
//        self.eventPrice.text = "250 QAR Onwards"
    }
}
