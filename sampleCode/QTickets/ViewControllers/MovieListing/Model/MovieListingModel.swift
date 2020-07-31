

import Foundation

public struct MovieListingModel: Codable {
    
    public let status: Bool?
    public let message: String?
    public let response: [MovieListingData]?
}

public struct MovieListingData: Codable {
    
    public let movieId: String?
    public let movieName: String?
    public let releasedate: String?
    public let language: String?
    public let experience: String?
    public let duration: String?
    public let imdbRating: String?
    public let pgRating: String?
    public let genre: String?
    public let trailerLink: String?
    public let poster: String?
    public let languages: [MovieListingLanguageData]?
    public let experiences: [MovieListingLanguageData]?
}

public struct MovieListingLanguageData: Codable {
    
    public let id: Int?
    public let name: String?
}


