//
//  MovieFilterRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on June 4, 2020

import Foundation
import SwiftyJSON


struct MovieFilterRootClass{

    var message : String!
    var response : MovieFilterResponse!
    var status : Bool!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        message = json["message"].stringValue
        let responseJson = json["response"]
        if !responseJson.isEmpty{
            response = MovieFilterResponse(fromJson: responseJson)
        }
        status = json["status"].boolValue
	}
}

struct EventFilterRootClass{

    var message : String!
    var response : EventFilterResponse!
    var status : Bool!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        message = json["message"].stringValue
        let responseJson = json["response"]
        if !responseJson.isEmpty{
            response = EventFilterResponse(fromJson: responseJson)
        }
        status = json["status"].boolValue
    }
}
