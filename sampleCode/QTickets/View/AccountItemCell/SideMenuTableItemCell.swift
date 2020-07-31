

import UIKit

class SideMenuTableItemCell: UITableViewCell {

    @IBOutlet var titleLablel : UILabel!
    @IBOutlet var itemImage : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
