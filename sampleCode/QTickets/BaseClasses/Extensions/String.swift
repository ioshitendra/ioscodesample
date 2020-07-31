

import Foundation
import CommonCrypto

public extension String {
    
    static func compareTwoString(firstString: String, secondString : String) -> Bool {
        if firstString == secondString {
            return true
        } else {
            return false
        }
    }
}
