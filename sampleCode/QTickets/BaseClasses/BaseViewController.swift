

import UIKit

class BaseViewController: UIViewController {

    var prefixArray = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        prefixArray = ["+974", "+973", "+971", "+968", "+91", "+93", "+355", "+213", "+376", "+54", "+61", "+822", "+375", "+975", "+591", "+55", "+359", "+86", "+57", "+269", "+506", "+53", "+31", "+20", "+33", "+220", "+995", "+49", "+233", "+1473", "+224", "+245", "+509", "+504", "+36", "+354", "+62", "+98", "+964", "+353", "+972", "+39", "+1876", "+81", "+962", "+7", "+254", "+965", "+371", "+231", "+218", "+423", "+370", "+352", "+60", "+223", "+356", "+52", "+377", "+976", "+212", "+264", "+674", "+977", "+64", "+505", "+92", "+685", "+378", "+966", "+381", "+232", "+65", "+421", "+386", "+677", "+252", "+27", "+34", "+249", "+597", "+46", "+41", "+963", "+66", "+676", "+216", "+90", "+256", "+44", "+1", "+998", "+58", "+84", "+260", "+263"]
    }
    
    func getShortDay(val: String) -> String {
           
           let availableMonth = val
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "EEEE"
           let availableDate = dateFormatter.date(from: availableMonth) ?? Date()
           dateFormatter.dateFormat = "EE"
           let finalString = dateFormatter.string(from: availableDate)
           return finalString
       }

}
