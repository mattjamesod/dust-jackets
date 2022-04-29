import SwiftUI

public struct Card<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @ViewBuilder var content: Content
    
    private var backgroundColor: Color {
        colorScheme == .dark ?
        Color(.systemGray5) : Color(.systemGray6)
    }
    
    public var body: some View {
        content
            .padding(.vertical, CardConstants.CONTAINER_VERTICAL_PADDING)
            .padding(.horizontal, CardConstants.CONTAINER_HORIZONTAL_PADDING)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
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
    
    public init(@ViewBuilder contentBuilder: () -> Content) {
        self.content = contentBuilder()
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
