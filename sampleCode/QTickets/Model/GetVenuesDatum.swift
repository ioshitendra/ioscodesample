//
//  GetVenuesDatum.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on May 9, 2020

import Foundation
import SwiftyJSON


class GetVenuesDatum : NSObject, NSCoding{

    var id : Int!
    var name : String!
    var latitude : Float!
    var longitude : Float!
    var address : String!
    var postalCode : String!
    var landmark : String!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        id = json["id"].intValue
        name = json["name"].stringValue
        latitude = json["latitude"].floatValue
        longitude = json["longitude"].floatValue
        address = json["address"].stringValue
        postalCode = json["postalCode"].stringValue
        landmark = json["landmark"].stringValue
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
        if name != nil{
        	dictionary["name"] = name
        }
        if latitude != nil{
        	dictionary["latitude"] = latitude
        }
        if longitude != nil{
        	dictionary["longitude"] = longitude
        }
        if address != nil{
        	dictionary["address"] = address
        }
        if postalCode != nil{
        	dictionary["postalCode"] = postalCode
        }
        if landmark != nil{
        	dictionary["landmark"] = landmark
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		id = aDecoder.decodeObject(forKey: "id") as? Int
		name = aDecoder.decodeObject(forKey: "name") as? String
		latitude = aDecoder.decodeObject(forKey: "latitude") as? Float
		longitude = aDecoder.decodeObject(forKey: "longitude") as? Float
		address = aDecoder.decodeObject(forKey: "address") as? String
		postalCode = aDecoder.decodeObject(forKey: "postalCode") as? String
		landmark = aDecoder.decodeObject(forKey: "landmark") as? String
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
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if latitude != nil{
			aCoder.encode(latitude, forKey: "latitude")
		}
		if longitude != nil{
			aCoder.encode(longitude, forKey: "longitude")
		}
		if address != nil{
			aCoder.encode(address, forKey: "address")
		}
		if postalCode != nil{
			aCoder.encode(postalCode, forKey: "postalCode")
		}
		if landmark != nil{
			aCoder.encode(landmark, forKey: "landmark")
		}

	}

}
