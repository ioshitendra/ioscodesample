

import Foundation

struct MovieListModel {
    
      var message : String?
      var response : [MovieListResponse]?
      var status : Bool?
    
    init(dict:[String:Any]) {
        response = [MovieListResponse]()
      
        let arr = dict["response"] as? [Any] ?? [Any]()
        for obj in arr {
            let dictIbj = obj as? [String:Any] ?? [String:Any]()
            let listObj = MovieListResponse(dict: dictIbj)
            response?.append(listObj);
        }
        self.message = dict["message"] as? String ?? ""
        self.status = dict["status"] as? Bool ?? false
    }
}


struct MovieListResponse {

    var duration : Int?
    var experience : String?
    var experiences : AnyObject?
    var genres : String?
    var imdbRating : Int?
    var language : String?
    var languageExperience : AnyObject?
    var languages : AnyObject?
    var movieId : String?
    var movieName : String?
    var pgRating : String?
    var poster : String?
    var releaseDate : String?
    var trailerUrl : String?

    init(dict:[String:Any]) {
       // print(dict)
        self.duration = dict["duration"] as? Int ?? 0
        self.experience = dict["experience"] as? String ?? ""
        self.experiences = dict["experiences"] as AnyObject?
        self.genres = dict["genres"] as? String ?? ""
        self.imdbRating = dict["imdbRating"] as? Int ?? 0
        self.language = dict["language"] as? String ?? ""
        self.languageExperience = dict["languageExperience"] as AnyObject?
        self.languages = dict["languages"] as AnyObject?
        self.movieId  = dict["movieId"] as? String ?? ""
        self.movieName = dict["movieName"] as? String ?? ""
        self.pgRating  = dict["pgRating"] as? String ?? ""
        self.poster  = dict["poster"] as? String ?? ""
        self.releaseDate  = dict["releaseDate"] as? String ?? ""
        self.trailerUrl  = dict["trailerUrl"] as? String ?? ""
    }
}
