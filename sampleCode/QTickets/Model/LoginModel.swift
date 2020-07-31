

import Foundation

private var MZObjectAssociationKey: UInt8 = 0

extension AppDelegate {
    
    var user: LoginModel! {
        get {
            return objc_getAssociatedObject(self, &MZObjectAssociationKey) as? LoginModel
        }
        set(newValue) {
            objc_setAssociatedObject(self, &MZObjectAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}
    



struct LoginModel: Decodable {
    
    let email : String?
    let gender : String?
    let id : String?
    let mobile : String?
    let name : String?
    let nationality : String?
    let prefix : String?
    let status : String?
    let verify : String?
    
    init(dict:[String:Any]) {
        self.email = dict["email"] as? String ?? ""
        self.gender = dict["gender"] as? String ?? ""
        self.id = dict["id"] as? String ?? ""
        self.mobile = dict["mobile"] as? String ?? ""
        self.name = dict["name"] as? String ?? ""
        self.nationality = dict["nationality"] as? String ?? ""
        self.prefix = dict["prefix"] as? String ?? ""
        self.status = dict["status"] as? String ?? ""
        self.verify = dict["verify"] as? String ?? ""
    }

}


struct LoginModelData {
    var userDetails : LoginUserDetail!
       init(dict:[String:Any]) {
           let dictObj = dict["userDetails"] as? [String: Any] ?? [String: Any]()
           userDetails = LoginUserDetail(dict: dictObj)
       }

}

struct LoginUserDetail {
    
      var dialCode : String!
      var email : String!
      var facebookId : String!
      var firstName : String!
      var gender : String!
      var googleId : String!
      var id : Int!
      var isEmailVerified : Bool!
      var isMobileVerified : Bool!
      var jwtToken : String!
      var lastName : String!
      var phoneNumber : String!
      var profilePicUrl : String!
      var userRole : String!
    
    init(dict:[String:Any]) {
        self.email = dict["email"] as? String ?? ""
        dialCode = dict["dialCode"] as? String ?? ""
        email = dict["email"] as? String ?? ""
        facebookId = dict["facebookId"] as? String ?? ""
        firstName = dict["firstName"] as? String ?? ""
        gender = dict["gender"] as? String ?? ""
        googleId = dict["googleId"] as? String ?? ""
        id = dict["id"] as? Int ?? 0
        isEmailVerified = dict["isEmailVerified"] as? Bool ?? false
        isMobileVerified = dict["isMobileVerified"] as? Bool ?? false
        jwtToken = dict["jwtToken"] as? String ?? ""
        lastName = dict["lastName"] as? String ?? ""
        phoneNumber = dict["phoneNumber"] as? String ?? ""
        profilePicUrl = dict["profilePicUrl"] as? String ?? ""
        userRole = dict["userRole"] as? String ?? ""
    }

}
