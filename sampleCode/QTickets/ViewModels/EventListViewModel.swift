

import Foundation

class EventListViewModel {
    
    typealias completionhandler = (EventListModel) -> Void
    var responseClosure:completionhandler!
    
    func APICall(url: String, completion: @escaping completionhandler)  {
        self.responseClosure = completion;
        NetworkManager.shared.requestGETURL(apiUrl: url, params: nil, headers: nil, success: { (JSONResponse) in
            let json = JSONResponse.dictionaryObject
            let listData = json ?? [String: Any]();
            let eventDataObj = EventListModel(dict: listData)
            self.responseClosure(eventDataObj);
        }, failure: {_ in
            Global.showAlertWithMessage(message: ConstantsMessages.kSomethingWrong)
            Global.dismissLoadingSpinner()
        })
    }
    
}
