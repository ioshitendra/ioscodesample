

import Foundation


extension Date {
    
    var weekdayName: String {
        let formatter = DateFormatter(); formatter.dateFormat = "E"
        return formatter.string(from: self as Date)
    }
    
    var weekdayNameFull: String {
        let formatter = DateFormatter(); formatter.dateFormat = "EEEE"
        return formatter.string(from: self as Date)
    }
    var monthName: String {
        let formatter = DateFormatter(); formatter.dateFormat = "MMMM"
        return formatter.string(from: self as Date)
    }
    var OnlyYear: String {
        let formatter = DateFormatter(); formatter.dateFormat = "YYYY"
        return formatter.string(from: self as Date)
    }
    
    var DatewithMonthDayWeek: String {
           let formatter = DateFormatter();
           formatter.dateFormat = "MMM dd EEE"
           //formatter.dateStyle = .medium ;
           return formatter.string(from: self as Date)
       }
    
    
    var DatewithMonth: String {
        let formatter = DateFormatter();
        formatter.dateFormat = "dd MMMM YYYY"
        //formatter.dateStyle = .medium ;
        return formatter.string(from: self as Date)
    }
    
    var DatewithYMD: String {
        let formatter = DateFormatter();
        formatter.dateFormat = "YYYY-MM-dd"
        //formatter.dateStyle = .medium ;
        return formatter.string(from: self as Date)
    }
    
    var dayOfTheWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    func startOfMonth() -> Date? {
        
        let calendar = Calendar.current
        let currentDateComponents = calendar.dateComponents([.year, .month], from: self)
        let startOfMonth = calendar.date(from: currentDateComponents)
        
        return startOfMonth
    }
    
    func dateByAddingMonths(_ monthsToAdd: Int) -> Date? {
        
        let calendar = Calendar.current
        var months = DateComponents()
        months.month = monthsToAdd
        
        return calendar.date(byAdding: months, to: self)
    }
    
    func endOfMonth() -> Date? {
        
        guard let plusOneMonthDate = dateByAddingMonths(1) else { return nil }
        
        let calendar = Calendar.current
        let plusOneMonthDateComponents = calendar.dateComponents([.year, .month], from: plusOneMonthDate)
        let endOfMonth = calendar.date(from: plusOneMonthDateComponents)?.addingTimeInterval(-1)
        
        return endOfMonth
        
    }
  
}

extension String {
  func toDate(withFormat format: String = "MM/dd/yyyy") -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    guard let date = dateFormatter.date(from: self) else {
      preconditionFailure("Take a look to your format")
    }
    return date
  }
}
