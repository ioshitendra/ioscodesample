

import Foundation

// Be sure to set the "DEBUG" symbol.
// Set it in the "Swift Compiler - Custom Flags" section, "Other Swift Flags" line. You add the DEBUG symbol with the -D DEBUG entry.


func print_QT4DebugMode(file: String = #file, line: Int = #line, function: String = #function) {
    
    #if DEBUG
    
    let time = "\n_______________________ DEBUG _______________________\n✅ \(Date())"
    let className = file.components(separatedBy: "/").last
    let filename = "\n✅ File Name: \(String(describing: className!))"
    let onMethod = "\n✅ Method Name: \(function)"
    let ofLine = "\n✅ Line: \(line)\n_____________________________________________________\n"
    let last = "\n*****************************************************"
    
    print(time, filename, onMethod, ofLine, last)
    #else
    #endif
}

func print_QT4DebugModeSimpleForm(items: Any, line: Int = #line) {
    
    #if DEBUG
    
    let time = "\n_______________________ DEBUG _______________________\n✅ \(Date())"
    let ofLine = "\n✅ Line: \(line)\n_____________________________________________________\n"
    let last = "\n*****************************************************"
    
    print(time, ofLine, items, last)
    
    #else
    
    #endif
}
