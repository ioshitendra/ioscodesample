import Foundation

struct EventDetailsModel {
    
    var message : String?
    var responses : [EventDetailsResponse]?
    var status : Bool?
    
    init(dict:[String:Any]) {
        
        responses = [EventDetailsResponse]()
        
        let arr = dict["response"] as? [String : Any] ?? [String : Any]()
        let listObj = EventDetailsResponse(dict: arr)
        responses?.append(listObj);
        
        self.message = dict["Message"] as? String ?? ""
        self.status = dict["status"] as? Bool ?? false
    }
}

struct EventDetailsResponse {
    
    var descriptionField : String?
    var eventDate : String?
    var eventId : String?
    var eventTitle : String?
    var eventVenues : [EventDetialsEventVenue]?
    var locationName : String?
    var posterPath : String?
    var showTime : String?
    var latitude: Double?
    var longitude: Double?
    var baseUrl: String?
    var Terms: String?
    var artistDetails: [ArtistDetails]?
    var userReviews: [UserReviews]?
    var faqEvents: [FaqEvents]?
    var eventGallery: [EventGallery]?
    
    init(dict:[String:Any]) {
        descriptionField = dict["description"] as? String ?? ""
        eventDate = dict["eventDate"] as? String ?? ""
        eventId = dict["eventId"] as? String ?? ""
        eventTitle = dict["eventTitle"] as? String ?? ""
        eventVenues = [EventDetialsEventVenue]()
        let eventVenuesArray = dict["eventVenues"] as? NSArray ?? NSArray()
        for eventVenuesJson in eventVenuesArray{
            let dictIbj = eventVenuesJson as? [String:Any] ?? [String:Any]()
            let value = EventDetialsEventVenue(dict: dictIbj)
            eventVenues?.append(value)
        }
        locationName = dict["locationName"] as? String ?? ""
        posterPath = dict["posterPath"] as? String ?? ""
        showTime = dict["showTime"] as? String ?? ""
        latitude = dict["latitude"] as? Double ?? 0.00
        longitude = dict["longitude"] as? Double ?? 0.00
        baseUrl = dict["baseUrl"] as? String ?? ""
        Terms = dict["termCondition"] as? String ?? ""
        artistDetails = [ArtistDetails]()
        let artistDetailsArray = dict["artistDetail"] as? [Any] ?? [Any]()
        for objArtist in artistDetailsArray {
            let dictObj = objArtist as? [String: Any] ?? [String: Any]()
            let value = ArtistDetails(dict: dictObj)
            artistDetails?.append(value)
        }
        userReviews = [UserReviews]()
        let userReviewsArray = dict["userReview"] as? [Any] ?? [Any]()
        for objreview in userReviewsArray {
            let dictObj = objreview as? [String: Any] ?? [String: Any]()
            let value = UserReviews(dict: dictObj)
            userReviews?.append(value)
        }
        faqEvents = [FaqEvents]()
        let faqEventsArray = dict["faq"] as? [Any] ?? [Any]()
        for objFaq in faqEventsArray {
            let dictObj = objFaq as? [String: Any] ?? [String: Any]()
            let value = FaqEvents(dict: dictObj)
            faqEvents?.append(value)
        }
        eventGallery = [EventGallery]()
        let eventGalleryArray = dict["eventGallery"] as? [Any] ?? [Any]()
        for objGallery in eventGalleryArray {
            let dictObj = objGallery as? [String: Any] ?? [String: Any]()
            let value = EventGallery(dict: dictObj)
            eventGallery?.append(value)
        }
    }
}

struct EventDetialsEventVenue {
    
    var eventVenueId : String?
    var venueName : String?
    init(dict:[String:Any]) {
        eventVenueId = dict["eventVenueId"] as? String ?? ""
        venueName = dict["venueName"] as? String ?? ""
    }
}

struct ArtistDetails {
    
    var name: String?
    var image: String?
    init(dict: [String: Any]) {
        name = dict["name"] as? String ?? ""
        image = dict["image"] as? String ?? ""
    }
}

struct UserEventReviews {
    var userName: String?
    var review: String?
    var reviewDate: String?
    var ratings: Int?
    
    init(dict: [String: Any]) {
        userName = dict["usreName"] as? String ?? ""
        review = dict["review"] as? String ?? ""
        reviewDate = dict["reviewDate"] as? String ?? ""
        ratings = dict["reviewRating"] as? Int ?? 0
    }
}

struct FaqEvents {
    var question: String?
    var answer: String?
    
    init(dict: [String: Any]) {
        question = dict["question"] as? String ?? ""
        answer = dict["answer"] as? String ?? ""
    }
}

struct EventGallery {
    var name: String?
    var video: String?
    var image: String?
    
    init(dict: [String: Any]) {
        name = dict["name"] as? String ?? ""
        video = dict["video"] as? String ?? ""
        image = dict["image"] as? String ?? ""
    }
}
