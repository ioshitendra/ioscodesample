

import Foundation

class HomeCountryListViewModel {
    
    typealias completionhandler = ([HomeCountryListResponse]) -> Void
    var responseClosure:completionhandler!

    func APICall(url: String, completion: @escaping completionhandler)  {
        self.responseClosure = completion;
        NetworkManager.shared.requestGETURL(apiUrl: url, params: nil, headers: nil, success: { (JSONResponse) in
            let countryListinData = HomeCountryListRootClass(fromJson: JSONResponse)
            if(countryListinData.status ?? false == true){
              self.responseClosure(countryListinData.response)
            }else{
                Global.showAlertWithMessage(message: countryListinData.message ?? "")
                 Global.dismissLoadingSpinner()
            }
        }, failure: {_ in
            Global.dismissLoadingSpinner()
        })
    }
    
}
