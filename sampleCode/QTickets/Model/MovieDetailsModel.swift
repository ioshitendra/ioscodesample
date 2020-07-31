

import Foundation

struct MovieDetailsModel {
    
    var message : String?
    var responses : [MovieDetailsResponse]?
    var status : Bool?
    
    init(dict:[String:Any]) {
        responses = [MovieDetailsResponse]()
        
        let arr = dict["response"] as? [String : Any] ?? [String : Any]()
        let listObj = MovieDetailsResponse(dict: arr)
        responses?.append(listObj);
        
        self.message = dict["Message"] as? String ?? ""
        self.status = dict["status"] as? Bool ?? false
    }
}

struct MovieDetailsResponse {
    
    var descriptionField : String?
    var duration : Int?
    var experience : String?
    var experiences : [MovieDetailsExperience]?
    var genres : String?
    var imdbRating : Int?
    var language : String?
    var languageExperience : [MovieDetailsLanguageExperience]?
    var languages : AnyObject?
    var metaDescription : String?
    var metaKeyword : String?
    var metaTitle : String?
    var movieId : String?
    var movieName : String?
    var movieType : String?
    var pgRating : String?
    var poster : String?
    var releaseDate : String?
    var trailerLink : String?
    var trailerUrl : String?
    var termCondition : String?
    var userReviews: [UserReviews]?
    var faq: [Faq]?
    var castCrew: [CastCrew]?
    var movieLinkToShare: String?
    
    init(dict:[String:Any]) {
        self.descriptionField = dict["description"] as? String ?? ""
        self.duration = dict["duration"] as? Int ?? 0
        self.experience = dict["experience"] as? String ?? ""
        self.experience = dict["experience"] as? String ?? ""
        experiences = [MovieDetailsExperience]()
        let arr = dict["experiences"] as? [Any] ?? [Any]()
        for obj in arr {
            let dictIbj = obj as? [String:Any] ?? [String:Any]()
            let listObj = MovieDetailsExperience(dict: dictIbj)
            experiences?.append(listObj);
        }
        genres = dict["genres"] as? String ?? ""
        imdbRating = dict["imdbRating"] as? Int ?? 0
        language = dict["language"] as? String ?? ""
        
        languageExperience = [MovieDetailsLanguageExperience]()
        let arr1 = dict["languageExperience"] as? [Any] ?? [Any]()
        for obj in arr1 {
            let dictIbj = obj as? [String:Any] ?? [String:Any]()
            let listObj = MovieDetailsLanguageExperience(dict: dictIbj)
            languageExperience?.append(listObj);
        }
        languages = dict["languages"] as AnyObject?
        metaDescription = dict["metaDescription"] as? String ?? ""
        metaKeyword = dict["metaKeyword"] as? String ?? ""
        metaTitle = dict["metaTitle"] as? String ?? ""
        movieId = dict[""] as? String ?? ""
        movieName = dict["movieName"] as? String ?? ""
        movieType = dict["movieType"] as? String ?? ""
        pgRating = dict["pgRating"] as? String ?? ""
        poster = dict["poster"] as? String ?? ""
        releaseDate = dict["releaseDate"] as? String ?? ""
        trailerLink = dict["trailerLink"] as? String ?? ""
        trailerUrl = dict["trailerUrl"] as? String ?? ""
        termCondition = dict["termCondition"] as? String ?? ""
        userReviews = [UserReviews]()
        let arrReview = dict["userReviews"] as? [Any] ?? [Any]()
        for obj in arrReview {
            let dictObj = obj as? [String:Any] ?? [String:Any]()
            let listObj = UserReviews(dict: dictObj)
            userReviews?.append(listObj)
        }
        faq = [Faq]()
        let arrFaq = dict["faq"] as? [Any] ?? [Any]()
        for obj in arrFaq {
            let dictObj = obj as? [String: Any] ?? [String: Any]()
            let listObj = Faq(dict: dictObj)
            faq?.append(listObj)
        }
        castCrew = [CastCrew]()
        let arrCast = dict["castCrew"] as? [Any] ?? [Any]()
        for obj in arrCast {
            let dictObj = obj as? [String: Any] ?? [String: Any]()
            let listObj = CastCrew(dict: dictObj)
            castCrew?.append(listObj)
        }
        movieLinkToShare = dict["movieLinkToShare"] as? String ?? ""
    }
}

struct MovieDetailsExperience {
    var id : Int?
    var name : String?
    init(dict:[String:Any]) {
        id = dict["id"] as? Int ?? 0
        name = dict["name"] as? String ?? ""
    }
}

struct MovieDetailsLanguageExperience {
    
    var experiences : [MovieDetailsExperience]?
    var languageId : Int?
    var languageName : String?
    init(dict:[String:Any]) {
        languageId = dict["languageId"] as? Int ?? 0
        languageName = dict["languageName"] as? String ?? ""
        
        let arr = dict["experiences"] as? [Any] ?? [Any]()
        for obj in arr {
            let dictIbj = obj as? [String:Any] ?? [String:Any]()
            let listObj = MovieDetailsExperience(dict: dictIbj)
            experiences?.append(listObj);
        }
    }
}

struct UserReviews {

    var userName: String?
    var review: String?
    var reviewDate: String?
    var reviewRating: Int?
    
    init(dict:[String:Any]) {
        userName = dict["usreName"] as? String ?? ""
        review = dict["review"] as? String ?? ""
        reviewDate = dict["reviewDate"] as? String ?? ""
        reviewRating = dict["reviewRating"] as? Int ?? 0
    }
}

struct Faq {

    var question: String?
    var answer: String?
    
    init(dict: [String: Any]) {
        question = dict["question"] as? String ?? ""
        answer = dict["answer"] as? String ?? ""
    }
}

struct CastCrew {
    
    var castName: String?
    var castImage: String?
    
    init(dict: [String: Any]) {
        castName = dict["castName"] as? String
        castImage = dict["castImage"] as? String
    }
}
