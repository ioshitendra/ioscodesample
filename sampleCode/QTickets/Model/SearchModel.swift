

import Foundation

struct SearchModel: Decodable {
    
    let id: String?
    let linkPath: String?
    let name: String?
    let description: String?
    let genre: String?
    let language: String?
    let poster: String?
    let showBrowser: String?
    let country: String?
    let rating: String?
    let eventListing: String?
    let url: String?
    let listingImage: String?

    
    
    init(dict:[String:Any]) {
        self.id = dict["id"] as? String ?? ""
        self.linkPath = dict["linkPath"] as? String ?? ""
        self.name = dict["name"] as? String ?? ""
        self.description = dict["description"] as? String ?? ""
        self.genre = dict["gen_ven"] as? String ?? ""
        self.language = dict["language"] as? String ?? ""
        self.poster = dict["poster"] as? String ?? ""
        self.showBrowser = dict["showBrowser"] as? String ?? ""
        self.country = dict["country"] as? String ?? ""
        self.rating = dict["rating"] as? String ?? ""
        self.eventListing = dict["EventListing"] as? String ?? ""
        self.url = dict["url"] as? String ?? ""
        self.listingImage = dict["Listing_Page_image"] as? String ?? ""
    }
}

