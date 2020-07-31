

import UIKit

class DatePickerVC: UIViewController {

    @IBOutlet weak var dataPicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        dataPicker.minimumDate = NSDate() as Date
        dataPicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    

    // MARK: - Navigation
    
    
    @IBAction func OKAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func CancelAction(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
       }
    
}

extension DatePickerVC {
    @objc func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            print("\(day) \(month) \(year)")
        }
    }
}
