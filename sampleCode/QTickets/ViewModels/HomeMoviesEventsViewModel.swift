

import Foundation


class HomeMoviesEventsViewModel {

    typealias completionhandler = (HomeData) -> Void
    var responseClosure:completionhandler!
    func APICall(url: String, completion: @escaping completionhandler)  {
        self.responseClosure = completion;
        NetworkManager.shared.requestGETURL(apiUrl: url, params: nil, headers: nil, success: { (JSONResponse) in
             
            let json = JSONResponse.dictionaryObject
            let responseData = json ?? [String: Any]();
            let homeDataObj = HomeData(dict: responseData)
            if homeDataObj.status ?? false {
                self.responseClosure(homeDataObj)
            } else {
                print_QT4DebugModeSimpleForm(items: "status value is false")
            }
        }, failure: {_ in
            Global.dismissLoadingSpinner()
        })
    }
}
