//
//  FaqModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on July 27, 2020

import Foundation


struct FaqModel {

    var response : [FaqResponse]?
    var statusCode : Int?
      init(dict:[String:Any]) {
        
        self.response = [FaqResponse]()
        let faqArray = dict["response"] as? [String : Any] ?? [String : Any]()
        let listObj = FaqResponse(dict: faqArray)
        self.response?.append(listObj);
        self.statusCode = dict["statusCode"] as? Int ?? 0
        }

}


struct FaqResponse{
    
    var message : String!
    var response : [Faq]!
    var status : Bool!
    
    init(dict:[String:Any]) {
        self.response = [Faq]()
        let arr = dict["response"] as? [Any] ?? [Any]()
        for obj in arr {
            let dictIbj = obj as? [String:Any] ?? [String:Any]()
            let listObj = Faq(dict: dictIbj)
            self.response?.append(listObj)
        }
        self.message = dict["message"] as? String ?? ""
        self.status = dict["status"] as? Bool ?? false
       }


}

