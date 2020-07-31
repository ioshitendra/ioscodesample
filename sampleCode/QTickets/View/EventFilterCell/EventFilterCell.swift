

import UIKit

class EventFilterCell: UITableViewCell {

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        if selected {
//            lbl.textColor = UIColor.AppFilterLabelSelectedColor()
//             @IBOutlet weak var lbl: UILabel!
//               @IBOutlet weak var img: UIImageView!.font = FontHelper.MontserratMediumFontWithSize(size: 12)
//            img.isHidden = false
//        } else {
//             @IBOutlet weak var lbl: UILabel!
//               @IBOutlet weak var img: UIImageView!.textColor = UIColor.AppFilterLabelUnselectedColor()
//             @IBOutlet weak var lbl: UILabel!
//               @IBOutlet weak var img: UIImageView!.font = FontHelper.MontserratRegularFontWithSize(size: 12)
//            imgcheck.isHidden = true
//        }
    }
    
}
