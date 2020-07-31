

import Foundation

class EventCategoryViewModel {
    
    typealias completionhandler = ([EventCategoryDatum]) -> Void
    var responseClosure:completionhandler!

    func APICall(url: String, completion: @escaping completionhandler)  {
        self.responseClosure = completion;
        NetworkManager.shared.requestGETURL(apiUrl: url, params: nil, headers: nil, success: { (JSONResponse) in
            let catListinData = EventCategoryRootClass(fromJson: JSONResponse)
            if(catListinData.httpStatus == 200){
              self.responseClosure(catListinData.data)
            }else{
                Global.showAlertWithMessage(message: catListinData.message ?? "")
                Global.dismissLoadingSpinner()
            }
        }, failure: {_ in
            Global.dismissLoadingSpinner()
        })
    }
    
}
