
import Foundation

class GetVenuesViewModel {
    
    typealias completionhandler = ([GetVenuesDatum]) -> Void
    var responseClosure:completionhandler!

    func APICall(url: String, completion: @escaping completionhandler)  {
        self.responseClosure = completion;
        NetworkManager.shared.requestGETURL(apiUrl: url, params: nil, headers: nil, success: { (JSONResponse) in
            let vanueListinData = GetVenuesRootClass(fromJson: JSONResponse)
            if(vanueListinData.httpStatus == 200){
              self.responseClosure(vanueListinData.data)
            }else{
                Global.showAlertWithMessage(message: vanueListinData.message ?? "")
                Global.dismissLoadingSpinner()
            }
        }, failure: {_ in
            Global.dismissLoadingSpinner()
        })
    }
    
}
