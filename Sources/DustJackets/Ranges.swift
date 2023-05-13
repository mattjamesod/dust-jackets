import SwiftUI

public extension ClosedRange {
    static func withIndifferentOrdering(_ bound1: Self.Bound, _ bound2: Self.Bound) -> Self {
        if bound1 <= bound2 {
            return bound1...bound2
        }
        else {
            return bound2...bound1
        }
    }
}

public extension DateInterval {
    static func withIndifferentOrdering(_ bound1: Date, _ bound2: Date) -> Self {
        if bound1 <= bound2 {
            return DateInterval(start: bound1, end: bound2)
        }
        else {
            return DateInterval(start: bound2, end: bound1)
        }
    }
}
