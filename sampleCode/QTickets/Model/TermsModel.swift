//
import Foundation

struct TermsModel {
    
    var response : [TermsResponse]?
    var statusCode : Int?
    
    init(dict:[String:Any]) {
        self.response = [TermsResponse]()
        let arr = dict["response"] as? [String : Any] ?? [String : Any]()
        let listObj = TermsResponse(dict: arr)
        self.response?.append(listObj);
        
        self.statusCode = dict["statusCode"] as? Int ?? 0
    }
    
}

struct  TermsResponse {
    
    var message : String!
    var response : String!
    var status : Bool!
    
    init(dict:[String:Any]) {
        print(dict)
        self.message = dict["message"] as? String ?? ""
        self.response = dict["response"] as? String ?? ""
        self.status = dict["status"] as? Bool ?? false
    }
}
