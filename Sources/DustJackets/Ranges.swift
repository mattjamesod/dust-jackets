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
