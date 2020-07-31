

import UIKit

class SideMenuTableHeaderCell: UITableViewCell {

    @IBOutlet var subview: UIView!
    @IBOutlet var profileimg: UIImageView!
    @IBOutlet var loginview: UIView!
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var signupBtn: UIButton!
    @IBOutlet var logoutBtn: UIButton!
    @IBOutlet var userImg: UIImageView!
    @IBOutlet var userNameLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layoutIfNeeded()
        
        self.profileimg.layer.cornerRadius = self.profileimg.frame.size.width / 2
        self.profileimg.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
