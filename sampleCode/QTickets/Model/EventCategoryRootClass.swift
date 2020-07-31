//
//  EventCategoryRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on May 9, 2020

import Foundation
import SwiftyJSON


struct EventCategoryRootClass {

    var message : String!
    var httpStatus : Int!
    var data : [EventCategoryDatum]!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        message = json["message"].stringValue
        httpStatus = json["httpStatus"].intValue
        data = [EventCategoryDatum]()
        let dataArray = json["data"].arrayValue
        for dataJson in dataArray{
            let value = EventCategoryDatum(fromJson: dataJson)
            data.append(value)
        }
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if message != nil{
        	dictionary["message"] = message
        }
        if httpStatus != nil{
        	dictionary["httpStatus"] = httpStatus
        }
        if data != nil{
        var dictionaryElements = [[String:Any]]()
        for dataElement in data {
        	dictionaryElements.append(dataElement.toDictionary())
        }
        dictionary["data"] = dictionaryElements
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    init(coder aDecoder: NSCoder)
	{
		message = aDecoder.decodeObject(forKey: "message") as? String
		httpStatus = aDecoder.decodeObject(forKey: "httpStatus") as? Int
		data = aDecoder.decodeObject(forKey: "data") as? [EventCategoryDatum]
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if message != nil{
			aCoder.encode(message, forKey: "message")
		}
		if httpStatus != nil{
			aCoder.encode(httpStatus, forKey: "httpStatus")
		}
		if data != nil{
			aCoder.encode(data, forKey: "data")
		}

	}

}
