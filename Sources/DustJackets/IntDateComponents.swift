import Foundation

public extension Int {
  var seconds: DateComponents { .init(second: self) }
  var minutes: DateComponents { .init(minute: self) }
  var hours: DateComponents { .init(hour: self) }
  var days: DateComponents { .init(day: self) }
  var weeks: DateComponents { .init(day: self * 7) }
  var months: DateComponents { .init(month: self) }
  var years: DateComponents { .init(year: self) }
}

public extension DateComponents {
  var fromNow: Date? {
    Calendar.current.date(byAdding: self, to: Date())
  }
    
  var ago: Date? {
    Calendar.current.date(byAdding: -self, to: Date())
  }
    
  static prefix func -(rhs: Self) -> DateComponents {
    .init(
      year: -rhs.year,
      month: -rhs.month,
      day: -rhs.day,
      hour: -rhs.hour,
      minute: -rhs.minute,
      second: -rhs.second
    )
  }
}
