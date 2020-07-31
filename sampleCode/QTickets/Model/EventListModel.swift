

import Foundation

struct EventListModel {
    
      var message : String?
      var response : [EventListResponse]?
      var status : Bool?
    
    init(dict:[String:Any]) {
        response = [EventListResponse]()
      
        let arr = dict["response"] as? [Any] ?? [Any]()
        for obj in arr {
            let dictIbj = obj as? [String:Any] ?? [String:Any]()
            let listObj = EventListResponse(dict: dictIbj)
            response?.append(listObj)
        }
        self.message = dict["message"] as? String ?? ""
        self.status = dict["status"] as? Bool ?? false
    }
}


struct EventListResponse {

    var eventDate : String?
    var eventId : String?
    var eventTitle : String?
    var locationName : String?
    var posterPath : String?
    var showTime : String?

    init(dict:[String:Any]) {
        eventDate = dict["eventDate"] as? String ?? ""
        eventId = dict["eventId"] as? String ?? ""
        eventTitle = dict["eventTitle"] as? String ?? ""
        locationName = dict["locationName"] as? String ?? ""
        posterPath = dict["posterPath"] as? String ?? ""
        showTime = dict["showTime"] as? String ?? ""
    }
}
