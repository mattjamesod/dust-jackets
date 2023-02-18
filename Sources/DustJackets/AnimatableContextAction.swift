import SwiftUI

public extension View {
    func animatableContextAction(_ action: @escaping () -> ()) {
        // SwiftUI transition bug
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            action()
        }
    }
}
