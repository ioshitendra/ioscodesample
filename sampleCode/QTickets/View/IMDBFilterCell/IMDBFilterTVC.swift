

import UIKit

class IMDBFilterTVC: UITableViewCell {

    @IBOutlet weak var lblmin: UILabel!
    @IBOutlet weak var sliderView: UISlider!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        let currentValue = Int(sender.value)
        print("Slider changing to \(currentValue) ?")
        lblmin.text = "\(currentValue) "
    }
    
}
