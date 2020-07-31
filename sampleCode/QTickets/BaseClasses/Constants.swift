
import UIKit

public struct Constants {

    static let APP_DELEGATE         = UIApplication.shared.delegate as! AppDelegate
    static var SCREEN_WIDTH         = UIScreen.main.bounds.width
    static var SCREEN_HEIGHT        = UIScreen.main.bounds.height
    static var DEFAULT_COUNTRY      = "Qatar"
    static var USERNAME             = "Shivam"
    static let LATITUDE             = "12.9784"
    static let LONGITUDE            = "77.6408"
    static let APP_USER_DEFAULTS    = UserDefaults.standard
}

public struct APIURL {
    
    static let BASE_URL      = "http://94.237.48.114/api/"
    static let HOME_BANNERS  = "https://api.q-tickets.com/V5.0/getbannereventmovies_banner?Country=Qatar"
    static let HOME_DATA     = "Mobile/Home"
    static let LOGIN_URL     = "User/login"
    //"https://api.q-tickets.com/V5.0/loginmobile?"
    static let RESET_PASSWORD = "User/ResetPassword"
    static let REG_URL       = "https://api.q-tickets.com/V5.0/registration_json?"
    static let SEARCH_URL    = "https://api.q-tickets.com/V5.0/getsearchresult?"
    static let COUNTRYLIST   = "Common/CountryList"
    static let MOVIE_Listing = "Movies/List?"
    static let Movies_MovieDetail = "Movies/MovieDetail/"
    static let EVENT_LISTING = "Concert/Event/List?"
    static let EVENT_DETAILS  = "Concert/EventDetail/"
    static let EVENT_Vanue   = "Event/GetVenues"
    static let EVENT_Categroy = "Event/GetEventCategories"
    static let MOVIE_FITER   = "Movies/GetFilters/"
    static let EVENT_FILTER  = "Concert/GetFilters/"
    static let FAQ           = "Common/FaqData"
    static let Terms         = "Common/TermCondition"
    static let ReviewEvent   = "MobileEvent/EventUserReview/"
    static let ReviewMoive   = "Mobile/MovieUserReview/"
    static let TrendingMovie = "Mobile/TrendingStroy/1"
}

public struct StoryboardName {
    
    static let mTabBarStoryboard                      = "TabBar"
    static let qLoginSIgnUp                           = "LoginSignUp"
    static let secondary                              = "Secondary"
    static let detailStoryboard                       = "DetailScreens"
    static let eventBookingStoryboard                 = "EventBooking"
    static let thankingyouStoryboard                  = "Thankyou"
}


public struct ViewControllerIdentifier {
    
    static let qTabVCIdentifier                     = "TabBarControllerIdentifier"
    static let qHomeVCIdentifier                    = "HomeVCIdentifier"
    static let qSearchVCIdentifer                   = "SearchVCIdentifer"
    static let qAccountVCIdentifier                 = "AccountVCIdentifier"
    static let qLoginVCIdentifier                   = "LoginVCIdentifier"
    static let qSignUpVCIdentifier                  = "RegistrationVCIdentifier"
    static let qForgotPasswordVCIdentifier          = "ForgotPasswordVCIdentifier"
    static let qEventsListingVCIdentifier           = "EventsListingVCIdentifier"
    static let qEventDetailVCIdentifier             = "EventDetailVCIdentifier"
    static let qEventFilterVC                       = "EventFilterVC"
    static let qBookDateTimeEventIdentifire         = "BookDateTimeEventIdentifire"
    static let qPaymentSummeryIdentifire            = "PaymentSummeryVC"
    static let qMovieListingVCIdentifier            = "MovieListingVCIdentifier"
    static let qMovietFilterVC                      = "MovieFilterVC"
    static let qMovieDetailVCIdentifier             = "MovieDetailVCIdentifier"
    static let qMovieDataCinemaSelectionIndetifire  = "MovieDateCinemaSelectionVC"
    static let qMoviewSeatLaout                     = "MovieSeatLaoutVC"
    static let qthankingyou                         = "ThankyouVC"
    static let qFaqVCIdentifier                     = "FaqVCIdentifier"
    static let qTermsVCIdentifier                   = "TermsVCIdentifier"
    static let qUserReviewIdentifier                = "ReviewVC"
}


public struct XIBTableCell {
    
    static let qHomeTableCell                        = "HomeMoviesTableCell"
    static let qAccountTableHeaderCell               = "SideMenuTableHeaderCell"
    static let qAccountTableItemCell                 = "SideMenuTableItemCell"
    static let qSearchCell                           = "SearchCell"
    static let qEventDetailCell                      = "EventDetailCell"
    static let qFAQSCell                             = "FAQSCell"
    static let qEventFilterCell                      = "EventFilterCell"
    static let qEventFilterHeaderCell                = "EventFilterHeaderCell"
    static let qEventFilterPriceCell                 = "EventFilterPriceCell"
    static let qMovieFilterCell                      = "FilterTVC"
    static let qMovieFilterIMDBCell                  = "IMDBFilterTVC"
}


public struct XIBCollectionCell {
        
    static let qHomeCollectionCell                   = "MovieHomeCollectionCell"
    static let qEventsListingCell                    = "EventsListingCell"
    static let qMovieListingCell                     = "MovieListingCVC"
}


public struct TableViewCellIdentifier {
    
    static let qHomeTableCellIdentifier              = "HomeMoviesTableCellIdentifier"
    static let qAccountHeaderCellIdentifier          = "SideMenuTableHeaderCellIdentifier"
    static let qAccountTableItemCellIdentifier       = "SideMenuTableItemCellIdentifier"
    static let qSearchCellIdentifier                 = "SearchCellIdentifier"
    static let qEventDetailCellIdentifier            = "EventDetailCellIdentifier"
    static let qFAQSCellIdentifier                   = "FAQSCellIdentifier"
    static let qEventFilterCellIdentifier            = "EventFilterCellIdentifier"
    static let qEventFilterHeaderCellIdentifier      = "EventFilterHeaderCellIdentifier"
    static let qEventFilterPriceCellIdentier         = "EventFilterPriceCellIdentifier"
    static let qMovieFilterIMDBCellIdentier          = "IMDBFilterTVC"
}

public struct CollectionViewCellIdentifier {
    
    static let qHomeCollectionCellId                 = "MovieHomeCollectionCellIdentifier"
    static let qBannerCellIdentifier                 = "BannerCellIdentifier"
    static let qEventsListingCellIdentifier          = "EventsListingCellIdentifier"
    static let qDateCellIdentifier                   = "DateCellIdentifier"
    static let qTimeCellIdentifier                   = "TimeCellIdentifier"
    static let qMovieListingCellIdentifire           = "MovieListingCollectionCellIdentifier"
    static let qCastCellIdentifier                   = "CastCellIdentifier"
    static let qArtistCellIdentifier                 = "ArtistCellIdentifier"
    static let qMovieGalleryCellIdentifier           = "MovieGalleryCellIdentifier"
}


public struct ConstantsMessages {
    
    static let kSomethingWrong      = "Something went wrong\nPlease try again soon!"
    static let kConnectionFailed    = "Oops...You do not seem to have a proper internet connection. Please try again after connecting to a valid internet connection".localized()
    static let kServerNil           = "Whoops! Looks like there is a problem with our server.\nPlease try again soon!"
    static let kNetworkFailure      = "Network connection lost.\nPlease try again!"
}

public struct UserDefaultKey {
    
    static let qLogInUserData            = "logInUserData"
}


public struct AssetsImages {
    
    static let qNavBarBack                        = UIImage(named: "cross")
    static let qSearchWhite                       = UIImage(named: "searchWhite")
    static let qAvatar                            = UIImage(named: "avatar")
    static let qFilterCheck                       = UIImage(named: "filterCheck")
    static let qFilterRangSlide                   = UIImage(named: "Rectangle")
    static let qNone                              = UIImage(named: "")
}

class Codes {
    static let API_SUCCESS_BOOL = 200
    static let API_FALUER_BOOL = 400
    
}
