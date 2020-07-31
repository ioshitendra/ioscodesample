//
//  HomeCountryListResponse.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on May 6, 2020

import Foundation
import SwiftyJSON


struct HomeCountryListResponse : Decodable{

    var id : Int?
    var countryName : String?
    var countryAlpha2Code : String?
    var countryAlpha3Code : String?
    var combinedCode : String?

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        id = json["id"].intValue
        countryName = json["countryName"].stringValue
        countryAlpha2Code = json["countryAlpha2Code"].stringValue
        countryAlpha3Code = json["countryAlpha3Code"].stringValue
        combinedCode = json["combinedCode"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if id != nil{
        	dictionary["id"] = id
        }
        if countryName != nil{
        	dictionary["countryName"] = countryName
        }
        if countryAlpha2Code != nil{
        	dictionary["countryAlpha2Code"] = countryAlpha2Code
        }
        if countryAlpha3Code != nil{
        	dictionary["countryAlpha3Code"] = countryAlpha3Code
        }
        if combinedCode != nil{
        	dictionary["combinedCode"] = combinedCode
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    init(coder aDecoder: NSCoder)
	{
		id = aDecoder.decodeObject(forKey: "id") as? Int
		countryName = aDecoder.decodeObject(forKey: "countryName") as? String
		countryAlpha2Code = aDecoder.decodeObject(forKey: "countryAlpha2Code") as? String
		countryAlpha3Code = aDecoder.decodeObject(forKey: "countryAlpha3Code") as? String
		combinedCode = aDecoder.decodeObject(forKey: "combinedCode") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if countryName != nil{
			aCoder.encode(countryName, forKey: "countryName")
		}
		if countryAlpha2Code != nil{
			aCoder.encode(countryAlpha2Code, forKey: "countryAlpha2Code")
		}
		if countryAlpha3Code != nil{
			aCoder.encode(countryAlpha3Code, forKey: "countryAlpha3Code")
		}
		if combinedCode != nil{
			aCoder.encode(combinedCode, forKey: "combinedCode")
		}

	}

}
