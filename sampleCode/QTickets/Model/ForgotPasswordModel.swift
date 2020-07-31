

import Foundation

struct ForgotModel {
    
    var userDetails : LoginUserDetail!
       init(dict:[String:Any]) {
           let dictObj = dict["userDetails"] as? [String: Any] ?? [String: Any]()
           userDetails = LoginUserDetail(dict: dictObj)
       }

}
