import SwiftUI

public struct Card<Content: View, Background: View>: View {
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

public extension Card where Background == Color {
    init(_ backgroundColorLight: Color = Color(.systemGray6),
         _ backgroundColorDark: Color = Color(.systemGray5),
         @ViewBuilder contentBuilder: () -> Content)
    {
        self.init(lightBackgroundBuilder: { backgroundColorLight }, darkBackgroundBuilder: { backgroundColorDark }) {
            contentBuilder()
        }
    }
    
    func lightBackground(_ color: Color) -> some View {
        var updatedView = self
        updatedView.lightBackgroundContent = color
        return updatedView
    }
    
    func darkBackground(_ color: Color) -> some View {
        var updatedView = self
        updatedView.darkBackgroundContent = color
        return updatedView
    }
}

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

struct Card_Previews: PreviewProvider {
    
    static var columns: [GridItem] =
             Array(repeating: .init(.flexible()), count: 2)
    
    static var example: some View {
        LazyVGrid(columns: columns) {
            Card {
                VStack {
                    HStack {
                        Text("Manana")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    HStack {
                        Text("Morning")
                        Spacer()
                    }
                }
            }
            Card {
                VStack {
                    HStack {
                        Text("Perro")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    HStack {
                        Text("Dog")
                        Spacer()
                    }
                }
            }
            Card {
                VStack {
                    HStack {
                        Text("Hola")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    HStack {
                        Text("Hello")
                        Spacer()
                    }
                }
            }
            .darkBackground(.red)
        }
    }
    
    static var previews: some View {
        example
            .preferredColorScheme(.light)
            .padding(.horizontal, 10)
        example
            .preferredColorScheme(.dark)
            .padding(.horizontal, 10)
    }
}
