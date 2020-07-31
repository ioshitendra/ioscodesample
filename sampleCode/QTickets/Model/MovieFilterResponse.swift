//
//  MovieFilterResponse.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on June 4, 2020

import Foundation
import SwiftyJSON


struct MovieFilterResponse {
    
    var filterDict = [[String :AnyObject]]()
    var name: String!
    var data: [MovieFilterGenre]!
    var dictToSaveNotest = [String :AnyObject]()
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        filterDict = [[String :AnyObject]]()
        for genresJson in json{
            name = genresJson.0
            data = [MovieFilterGenre]()
            dictToSaveNotest = [String :AnyObject]()
            for obj in genresJson.1 {
                let temp = MovieFilterGenre(fromJson: obj.1)
                data.append(temp)
                
            }
            dictToSaveNotest .updateValue(name as AnyObject, forKey: "title")
            dictToSaveNotest .updateValue(data as AnyObject, forKey: "notesField")
            filterDict.append(dictToSaveNotest)
        }
        dictToSaveNotest .updateValue("Imdb Rating" as AnyObject, forKey: "title")
        data = [MovieFilterGenre]()
        dictToSaveNotest .updateValue(data as AnyObject, forKey: "notesField")
        filterDict.append(dictToSaveNotest)
    }
}


struct EventFilterResponse {
    
    var filterDict = [[String :AnyObject]]()
    var name: String!
    var data: [EventFilterGenre]!
    var dictToSaveNotest = [String :AnyObject]()
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        filterDict = [[String :AnyObject]]()
        for genresJson in json{
            name = genresJson.0
            data = [EventFilterGenre]()
            dictToSaveNotest = [String :AnyObject]()
            for obj in genresJson.1 {
                let temp = EventFilterGenre(fromJson: obj.1)
                data.append(temp)
                
            }
            dictToSaveNotest .updateValue(name as AnyObject, forKey: "title")
            dictToSaveNotest .updateValue(data as AnyObject, forKey: "notesField")
            filterDict.append(dictToSaveNotest)
        }
        //        dictToSaveNotest .updateValue("Price Range" as AnyObject, forKey: "title")
        //        data = [EventFilterGenre]()
        //        dictToSaveNotest .updateValue(data as AnyObject, forKey: "notesField")
        //        filterDict.append(dictToSaveNotest)
    }
}
