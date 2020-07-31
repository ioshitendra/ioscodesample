
import Foundation

class TrendingMovieViewModel {

    typealias completionhandler = (TrendingStory) -> Void
    var responseClosure:completionhandler!
    func APICall(url: String, completion: @escaping completionhandler)  {
        self.responseClosure = completion;
        NetworkManager.shared.requestGETURL(apiUrl: url, params: nil, headers: nil, success: { (JSONResponse) in
             
            let json = JSONResponse.dictionaryObject
            let responseData = json?["response"] as? [String: Any] ?? [String: Any]();
            let trendingDataObj = TrendingStory(dict: responseData)
            if trendingDataObj.status ?? false {
                self.responseClosure(trendingDataObj)
            } else {
                print_QT4DebugModeSimpleForm(items: "status value is false")
            }
        }, failure: {_ in
            Global.dismissLoadingSpinner()
        })
    }
}
