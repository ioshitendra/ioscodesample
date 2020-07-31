
import Foundation

class FAQViewModel {
    
    typealias completionhandler = (FaqModel) -> Void
    var responseClosure:completionhandler!

    func APICall(url: String, completion: @escaping completionhandler)  {
        self.responseClosure = completion;
        NetworkManager.shared.requestGETURL(apiUrl: url, params: nil, headers: nil, success: { (JSONResponse) in
          let json = JSONResponse.dictionaryObject
            let listData = json ?? [String: Any]();
            print(listData)
            let faqDataObj = FaqModel(dict: listData)
            self.responseClosure(faqDataObj);
        }, failure: {_ in
            Global.dismissLoadingSpinner()
        })
    }
    
}
