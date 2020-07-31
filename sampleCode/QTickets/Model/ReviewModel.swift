
import Foundation

struct ReviewModel {
    
    var response : [ReviewResponse]?
    var statusCode : Int?
    init(dict:[String:Any]) {
        self.response = [ReviewResponse]()
        let reviewArray = dict["response"] as? [String : Any] ?? [String : Any]()
        let listObj = ReviewResponse(dict: reviewArray)
        self.response?.append(listObj);
        self.statusCode = dict["statusCode"] as? Int ?? 0
    }
    
}


struct ReviewResponse{
    
    var message : String!
    var response : [UserReviews]!
    var status : Bool!
    
    init(dict:[String:Any]) {
        self.response = [UserReviews]()
        let arr = dict["response"] as? [Any] ?? [Any]()
        for obj in arr {
            let dictIbj = obj as? [String:Any] ?? [String:Any]()
            let listObj = UserReviews(dict: dictIbj)
            self.response?.append(listObj)
        }
        self.message = dict["message"] as? String ?? ""
        self.status = dict["status"] as? Bool ?? false
    }
    
    
}


