

import Foundation

class ReviewViewModel {
    
    typealias completionhandler = (ReviewModel) -> Void
    var responseClosure:completionhandler!

    func APICall(url: String, completion: @escaping completionhandler)  {
        self.responseClosure = completion;
        NetworkManager.shared.requestGETURL(apiUrl: url, params: nil, headers: nil, success: { (JSONResponse) in
          let json = JSONResponse.dictionaryObject
            let listData = json ?? [String: Any]();
            print(listData)
            let termsDataObj = ReviewModel(dict: listData)
            self.responseClosure(termsDataObj);
        }, failure: {_ in
            Global.dismissLoadingSpinner()
        })
    }
    
}
