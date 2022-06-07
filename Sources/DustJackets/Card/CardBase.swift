import SwiftUI

public struct CardBase<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @ViewBuilder var content: Content
    
    var color: Color
    
    var flip: (() -> ())?
    
    private var cardBack: some View {
        RoundedRectangle(cornerRadius: CardConstants.CORNER_RADIUS)
            .foregroundColor(color)
            .if(colorScheme == .light) { view in
                view.shadow(
                    color: .gray,
                    radius: CardConstants.SHADOW_RADIUS,
                    x: CardConstants.SHADOW_OFFSET,
                    y: CardConstants.SHADOW_OFFSET
                )
            }
    }
    
    public var body: some View {
        ZStack {
            if flip != nil {
                cardBack.onTapGesture(perform: flip!)
            }
            else {
                cardBack
            }
            content
        }
    }
    
    public init(@ViewBuilder contentBuilder: () -> Content, color: Color, flip: @escaping () -> ()) {
        content = contentBuilder()
        self.color = color
        self.flip = flip
    }
    
    public init(@ViewBuilder contentBuilder: () -> Content, color: Color) {
        content = contentBuilder()
        self.color = color
        self.flip = nil
    }
}
