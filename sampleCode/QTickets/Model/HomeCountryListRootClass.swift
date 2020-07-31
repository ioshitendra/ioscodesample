//
//  HomeCountryListRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on May 6, 2020

import Foundation
import SwiftyJSON


struct HomeCountryListRootClass {

    var status : Bool!
    var message : String!
    var response : [HomeCountryListResponse]!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        status = json["status"].boolValue
        message = json["message"].stringValue
        response = [HomeCountryListResponse]()
        let responseArray = json["response"].arrayValue
        for responseJson in responseArray{
            let value = HomeCountryListResponse(fromJson: responseJson)
            response.append(value)
        }
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if status != nil{
        	dictionary["status"] = status
        }
        if message != nil{
        	dictionary["message"] = message
        }
        if response != nil{
        var dictionaryElements = [[String:Any]]()
        for responseElement in response {
        	dictionaryElements.append(responseElement.toDictionary())
        }
        dictionary["response"] = dictionaryElements
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
     init(coder aDecoder: NSCoder)
	{
		status = aDecoder.decodeObject(forKey: "status") as? Bool
		message = aDecoder.decodeObject(forKey: "message") as? String
		response = aDecoder.decodeObject(forKey: "response") as? [HomeCountryListResponse]
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if message != nil{
			aCoder.encode(message, forKey: "message")
		}
		if response != nil{
			aCoder.encode(response, forKey: "response")
		}

	}

}
