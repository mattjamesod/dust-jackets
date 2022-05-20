import SwiftUI

public struct CardBase<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @ViewBuilder var content: Content
    
    var color: Color
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7.5)
                .foregroundColor(color)
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
    
    public init(@ViewBuilder contentBuilder: () -> Content, color: Color) {
        content = contentBuilder()
        self.color = color
    }
}
