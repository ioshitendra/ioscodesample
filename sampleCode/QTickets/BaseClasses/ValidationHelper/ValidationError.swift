
import UIKit
import Localize_Swift

public class ValidationError: NSObject {
    
    public enum OfType : Error {
        
        case ErrorWithMessage(message: String)
        
        case Empty
        case EmptyEmail
        case EmptyPassword
        case EmptyConfirmPassword
        case EmptyCurrentPassword
        case EmptyOTP
        case EmptyNewPassword
        case EmptyFullName
        case EmptyFirstName
        case EmptyLastName
        case EmptyUserName
        case EmptyName
        case EmptyMobileNumber
        case EmptyAddress
        case EmptyCity
        case EmptyZone
        case EmptyState
        case EmptyCountry
        case EmptyPostalCode
        case EmptyGender
        case EmptyCouponCode
        case EmptyMessage

        case EmptyTrackId
        
        case TermsAndCondition
        
        case ValidEmail
        case ValidPassword
        case ValidMobileNumber
        
        case MismatchPassword
        case MismatchPassword2
        
        case EmptyUserProfile
        case NamePrefix
        case AgeValidation
        case TermsValidation
        case LocationTurnOn
        case CountryCode
    }
}

extension ValidationError.OfType {
    
    var description: String {
        switch self {
            
        case .ErrorWithMessage(let message):
            return message
            
        case .Empty:
            return "Can not blank"
        case .EmptyEmail:
            return "key_email_cannot_blank".localized()
        case .EmptyPassword:
            return "key_password_cannot_blank".localized()
        case .EmptyConfirmPassword:
            return "key_confirm_password_blank".localized()
        case .EmptyCurrentPassword:
            return "key_current_password_blank".localized()
        case .EmptyNewPassword:
            return "key_new_password_blank".localized()
        case .EmptyOTP:
            return "key_otp_can_not_blank".localized()
        case .TermsAndCondition:
            return ""
            
        case .EmptyFullName:
            return ""
        case .EmptyFirstName:
            return "key_first_name_blank".localized()
        case .EmptyLastName:
            return "key_last_name_blank".localized()
        case .EmptyUserName:
            return ""
        case .EmptyName:
            return "key_name_blank".localized()
            
            
        case .EmptyMobileNumber:
            return "key_empty_mobile".localized()
        case .EmptyAddress:
            return "key_address_blank".localized()
        case .EmptyCity:
            return "key_city_blank".localized()
        case .EmptyZone:
            return "key_zone_blank".localized()
        case .EmptyState:
            return ""
        case .EmptyCountry:
            return "key_country_blank".localized()
        case .EmptyPostalCode:
            return "key_postal_blank".localized()
        case .EmptyCouponCode:
            return "key_coupon_blank".localized()
        case .EmptyMessage:
            return "key_messsage_blank".localized()
        case .ValidEmail:
            return "key_email_valid".localized()
        case .ValidPassword:
            return "key_password_valid".localized()
        case .ValidMobileNumber:
            return "key_mobile_valid".localized()
        case .MismatchPassword:
            return "key_mismatch_password".localized()
        case .MismatchPassword2:
            return "key_mismatch_password2".localized()
        case .EmptyUserProfile:
            return ""
        case .EmptyGender:
            return "key_select_gender".localized()
        case .EmptyTrackId:
            return  ""
        case .NamePrefix:
            return "key_name_prefix".localized()
        case .AgeValidation:
            return "key_age_validation".localized()
        case .TermsValidation:
            return "key_terms_validation".localized()
        case .LocationTurnOn:
            return "key_location_turnOn".localized()
        case .CountryCode:
            return "key_choose_country_code".localized()
            
        }
    }
}

