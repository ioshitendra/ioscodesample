//
//  MovieFilterGenre.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on June 4, 2020

import Foundation
import SwiftyJSON


struct MovieFilterGenre {
    var id : Int?
    var name : String?
    var isCheck : Bool?
	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        id = json["id"].intValue
        name = json["name"].stringValue
        isCheck = false
	}
}

struct EventFilterGenre {
    var id : Int?
    var name : String?
    var isCheck : Bool?
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["id"].intValue
        name = json["name"].stringValue
        isCheck = false
    }
}
