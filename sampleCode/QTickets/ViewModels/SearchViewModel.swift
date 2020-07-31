

import Foundation
import UIKit

class SearchViewModel {

    
    typealias completionhandler = ([SearchModel]) -> Void
    var responseClosure:completionhandler!

    func APICall(url: String, completion: @escaping completionhandler)  {
        var SearchDataArray = [SearchModel]()
        self.responseClosure = completion;
        NetworkManager.shared.requestGETURL(apiUrl: url, params: nil, headers: nil, success: { (JSONResponse) in
            
             
            let json = JSONResponse.dictionaryObject
            let itemsArray = json!["items"] as? [Any] ?? [Any]();
            for obj in itemsArray {
                let dictObj = obj as? [String:Any] ?? [String:Any] ();
                let homeBannerObj = SearchModel(dict: dictObj);
                SearchDataArray.append(homeBannerObj)
            }
            self.responseClosure(SearchDataArray);
        }, failure: {_ in
            Global.dismissLoadingSpinner()
        })
    }

}
