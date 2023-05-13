import SwiftUI

public extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
    
    mutating func clamp(to limits: ClosedRange<Self>) {
        self = min(max(self, limits.lowerBound), limits.upperBound)
    }
}
