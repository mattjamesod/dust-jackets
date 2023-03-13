import SwiftUI

public typealias Size = SwiftUI.CGSize

public extension View {
    func frame(minSize: Size) -> some View {
        self.frame(
            minWidth: minSize.width,
            maxWidth: .infinity,
            minHeight: minSize.height,
            maxHeight: .infinity
        )
    }
}
