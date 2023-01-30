import Foundation

public extension Date {
    var dayName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
    }
    
    var startOfDay: Self {
        Calendar.current.startOfDay(for: self)
    }
}
