
import Foundation
class ForgotPasswordViewModel {

    typealias completionhandler = (ForgotModel) -> Void
    var responseClosure:completionhandler!
    typealias errorResponse = (Error) -> Void
    var errorClosure: errorResponse!
    func APICall(url: String, param: [String:AnyObject], completion: @escaping completionhandler,error: @escaping errorResponse)  {
        self.responseClosure = completion;
        let hea = ["Content-Type":"application/json"]
        NetworkManager.shared.requestRawPOSTURL(apiUrl: url, params: param, headers: hea, success: { (JSONResponse) in
            print(JSONResponse)
            let json = JSONResponse.dictionaryObject
            let responseData = json ?? [String: Any]();
            let LoginDataObj = ForgotModel(dict: responseData)
            self.responseClosure(LoginDataObj);
        }, failure: {(error) in
            Global.dismissLoadingSpinner()
        })
    }
}

