
import Foundation
import UIKit

class MovieListViewModel {

    
    typealias completionhandler = (MovieListModel) -> Void
    var responseClosure:completionhandler!

    func APICall(url: String, completion: @escaping completionhandler)  {
        self.responseClosure = completion;
        NetworkManager.shared.requestGETURL(apiUrl: url, params: nil, headers: nil, success: { (JSONResponse) in
            let json = JSONResponse.dictionaryObject
            let listData = json ?? [String: Any]();
            let movieDataObj = MovieListModel(dict: listData)
            self.responseClosure(movieDataObj);
        }, failure: {_ in
            Global.dismissLoadingSpinner()
        })
    }

}
