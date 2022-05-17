import SwiftUI

public struct CardBase<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @ViewBuilder var content: Content
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7.5)
                .foregroundColor(Color(.systemGray5))
                .if(colorScheme == .light) { view in
                    view.shadow(
                        color: .gray,
                        radius: 3,
                        x: 1.5,
                        y: 1.5
                    )
                }
            content
        }
    }
    
    public init(@ViewBuilder contentBuilder: () -> Content) {
        content = contentBuilder()
    }
}
