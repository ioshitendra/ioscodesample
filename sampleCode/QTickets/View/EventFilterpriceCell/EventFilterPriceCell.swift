

import UIKit

class EventFilterPriceCell: UITableViewCell {
    @IBOutlet weak var sliderView: UISlider!
    @IBOutlet weak var lblMin: UILabel!
    @IBOutlet weak var lblMax: UILabel!
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
           lblMin.text = "\(currentValue)" + " QAR"
       }
    
}
