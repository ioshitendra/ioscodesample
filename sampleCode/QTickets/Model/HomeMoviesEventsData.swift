

import Foundation

struct HomeData {
    
    let status : Bool?
    let message : String?
    var response : [ResponseHome]?

    init(dict:[String:Any]) {
        self.status = dict["status"] as? Bool ?? false
        self.message = dict["message"] as? String ?? ""
        response = [ResponseHome]()
        let arrobj = dict["response"] as? [Any] ?? [Any]()
        for obj in arrobj {
            let dictObj = obj as? [String: Any] ?? [String: Any]()
            let value = ResponseHome(dict: dictObj)
            response?.append(value)
        }
    }
}


struct ResponseHome {
    
    var type: String?
    var heading: String?
    var data: [HomeGenericData]?
    var count: Int?
    
    init(dict:[String:Any]) {
        type = dict["type"] as? String ?? ""
        heading = dict["heading"] as? String ?? ""
        data = [HomeGenericData]()
        let arrObj = dict["data"] as? [Any] ?? [Any]()
        for obj in arrObj {
            let dictObj = obj as? [String: Any] ?? [String: Any]()
            let value = HomeGenericData(dict: dictObj)
            data?.append(value)
        }
        count = dict["count"] as? Int ?? 0
    }
}


struct HomeGenericData {
 
    var movieId: String?
    var movieName: String?
    var language: String?
    var experience: String?
    var duration: Int?
    var imdbRating: Int?
    var pgRating: String?
    var genres: String?
    var poster: String?
    var eventId: String?
    var eventTitle: String?
    var eventDate: String?
    var showTime: String?
    var locationName: String?
    var posterPath: String?
    
    init(dict: [String: Any]) {
        self.movieId = dict["movieId"] as? String ?? ""
        self.movieName = dict["movieName"] as? String ?? ""
        self.language = dict["language"] as? String ?? ""
        self.experience = dict["experience"] as? String ?? ""
        self.duration = dict["duration"] as? Int ?? 0
        self.imdbRating = dict["imdbRating"] as? Int ?? 0
        self.pgRating = dict["pgRating"] as? String ?? ""
        self.genres = dict["genres"] as? String ?? ""
        self.poster = dict["poster"] as? String ?? ""
        self.eventId = dict["eventId"] as? String ?? ""
        self.eventTitle = dict["eventTitle"] as? String ?? ""
        self.eventDate = dict["eventDate"] as? String ?? ""
        self.showTime = dict["showTime"] as? String ?? ""
        self.locationName = dict["locationName"] as? String ?? ""
        self.posterPath = dict["posterPath"] as? String ?? ""
    }
}
