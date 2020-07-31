import Foundation
import UIKit

class EventDetailsViewModel {

    
    typealias completionhandler = (EventDetailsModel) -> Void
    var responseClosure:completionhandler!

    func APICall(url: String, completion: @escaping completionhandler)  {
        self.responseClosure = completion;
        NetworkManager.shared.requestGETURL(apiUrl: url, params: nil, headers: nil, success: { (JSONResponse) in
            let json = JSONResponse.dictionaryObject
            let listData = json ?? [String: Any]();
            print(listData)
            let eventDataObj = EventDetailsModel(dict: listData)
            self.responseClosure(eventDataObj);
        }, failure: {_ in
            Global.dismissLoadingSpinner()
        })
    }

}
