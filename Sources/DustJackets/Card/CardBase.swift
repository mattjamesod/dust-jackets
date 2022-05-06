import SwiftUI

public struct CardBase<Content: View, Background: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @ViewBuilder var content: Content
    @ViewBuilder var lightBackgroundContent: Background
    @ViewBuilder var darkBackgroundContent: Background
    
    private var backgroundContent: Background {
        colorScheme == .dark ?
            darkBackgroundContent :
            lightBackgroundContent
    }
    
    public var body: some View {
        content
            .padding(.vertical, CardConstants.CONTAINER_VERTICAL_PADDING)
            .padding(.horizontal, CardConstants.CONTAINER_HORIZONTAL_PADDING)
            .frame(maxWidth: .infinity)
            .background(backgroundContent)
            .cornerRadius(CardConstants.CORNER_RADIUS)
            .if(colorScheme == .light) { view in
                view.shadow(
                    color: .gray,
                    radius: CardConstants.SHADOW_RADIUS,
                    x: CardConstants.SHADOW_OFFSET,
                    y: CardConstants.SHADOW_OFFSET
                )
            }
    }
    
    public init(
        @ViewBuilder lightBackgroundBuilder: () -> Background,
        @ViewBuilder darkBackgroundBuilder: () -> Background,
        @ViewBuilder contentBuilder: () -> Content)
    {
        lightBackgroundContent = lightBackgroundBuilder()
        darkBackgroundContent = darkBackgroundBuilder()
        content = contentBuilder()
    }
}
