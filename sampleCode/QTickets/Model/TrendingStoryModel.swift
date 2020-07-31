

import Foundation

struct TrendingStory {
    
    let status : Bool?
    let message : String?
    var response : [TrendingData]?

    init(dict:[String:Any]) {
        self.status = dict["status"] as? Bool ?? false
        self.message = dict["message"] as? String ?? ""
        response = [TrendingData]()
        let arrobj = dict["response"] as? [Any] ?? [Any]()
        for obj in arrobj {
            let dictObj = obj as? [String: Any] ?? [String: Any]()
            let value = TrendingData(dict: dictObj)
            response?.append(value)
        }
    }
}


struct TrendingData {
 
    var stroyName: String?
    var stroyVideo: String?
    
    init(dict: [String: Any]) {
        self.stroyName = dict["stroyName"] as? String ?? ""
        self.stroyVideo = dict["stroyVideo"] as? String ?? ""
    }
}
