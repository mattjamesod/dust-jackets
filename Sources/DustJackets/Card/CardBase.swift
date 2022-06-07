import SwiftUI

public struct CardBase<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @ViewBuilder var content: Content
    
    var color: Color
    
    var reverseMethod: (() -> ())?
    
    private var cardBack: some View {
        RoundedRectangle(cornerRadius: CardConstants.defaults.CORNER_RADIUS)
            .foregroundColor(color)
            .if(colorScheme == .light) { view in
                view.shadow(
                    color: .gray,
                    radius: CardConstants.defaults.SHADOW_RADIUS,
                    x: CardConstants.defaults.SHADOW_OFFSET,
                    y: CardConstants.defaults.SHADOW_OFFSET
                )
            }
    }
    
    public var body: some View {
        ZStack {
            if reverseMethod != nil {
                cardBack.onTapGesture(perform: reverseMethod!)
            }
            else {
                cardBack
            }
            content
        }
    }
    
    public init(@ViewBuilder contentBuilder: () -> Content, color: Color, reverseMethod: @escaping () -> ()) {
        content = contentBuilder()
        self.color = color
        self.reverseMethod = reverseMethod
    }
    
    public init(@ViewBuilder contentBuilder: () -> Content, color: Color) {
        content = contentBuilder()
        self.color = color
        self.reverseMethod = nil
    }
}
