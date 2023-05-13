import SwiftUI

public extension Binding where Value: Equatable {
    init(_ source: Binding<Value?>, deselectTo: Value) {
        self.init(get: { source.wrappedValue ?? deselectTo },
                  set: { source.wrappedValue = $0 }
        )
    }
}
