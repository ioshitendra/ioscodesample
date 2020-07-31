
import Foundation

struct RegistrationModel: Decodable {

    let email : String?
    let errorcode : String?
    let errormsg : String?
    let id : String?
    let mobile : String?
    let name : String?
    let nationality : String?
    let prefix : String?
    let status : String?
    let verify : String?
    
    init(dict:[String:Any]) {
        self.email = dict["email"] as? String ?? ""
        self.errorcode = dict["errorcode"] as? String ?? ""
        self.errormsg = dict["errormsg"] as? String ?? ""
        self.id = dict["id"] as? String ?? ""
        self.mobile = dict["mobile"] as? String ?? ""
        self.name = dict["name"] as? String ?? ""
        self.nationality = dict["nationality"] as? String ?? ""
        self.prefix = dict["prefix"] as? String ?? ""
        self.status = dict["status"] as? String ?? ""
        self.verify = dict["verify"] as? String ?? ""
    }

}
