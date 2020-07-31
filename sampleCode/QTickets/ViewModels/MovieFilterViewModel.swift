
import Foundation

class MovieFilterViewModel {
    
    typealias completionhandler = ([[String : AnyObject]]) -> Void
    var responseClosure:completionhandler!

    func APICall(url: String, completion: @escaping completionhandler)  {
        self.responseClosure = completion;
        NetworkManager.shared.requestGETURL(apiUrl: url, params: nil, headers: nil, success: { (JSONResponse) in
            let movieFilterListinData = MovieFilterRootClass(fromJson: JSONResponse)
            if(movieFilterListinData.status == true){
                self.responseClosure(movieFilterListinData.response.filterDict)
            }else{
                Global.showAlertWithMessage(message: movieFilterListinData.message ?? "")
                Global.dismissLoadingSpinner()
            }
        }, failure: {_ in
            Global.dismissLoadingSpinner()
        })
    }
    
}
