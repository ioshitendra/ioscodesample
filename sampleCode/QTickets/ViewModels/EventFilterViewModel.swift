

import Foundation

class EventFilterViewModel {
    
    typealias completionhandler = ([[String : AnyObject]]) -> Void
    var responseClosure:completionhandler!

    func APICall(url: String, completion: @escaping completionhandler)  {
        self.responseClosure = completion;
        NetworkManager.shared.requestGETURL(apiUrl: url, params: nil, headers: nil, success: { (JSONResponse) in
            let eventFilterListinData = EventFilterRootClass(fromJson: JSONResponse)
            if(eventFilterListinData.status == true){
                self.responseClosure(eventFilterListinData.response.filterDict)
            }else{
                Global.showAlertWithMessage(message: eventFilterListinData.message ?? "")
                Global.dismissLoadingSpinner()
            }
        }, failure: {_ in
            Global.dismissLoadingSpinner()
        })
    }
    
}
