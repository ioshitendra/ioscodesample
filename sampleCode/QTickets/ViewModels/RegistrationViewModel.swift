

import Foundation

class RegistrationViewModel {
    
    typealias completionhandler = (RegistrationModel) -> Void
    var responseClosure:completionhandler!

    func APICall(url: String, completion: @escaping completionhandler)  {
        self.responseClosure = completion;
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        NetworkManager.shared.requestGETURL(apiUrl: encodedUrl, params: nil, headers: nil, success: { (JSONResponse) in
            
            let json = JSONResponse.arrayObject
            let itemsDict = json?[0] as? [String:Any] ?? [String:Any]()
            let regData = RegistrationModel(dict: itemsDict);
            self.responseClosure(regData);
        }, failure: {_ in
            Global.dismissLoadingSpinner()
        })
    }
}
