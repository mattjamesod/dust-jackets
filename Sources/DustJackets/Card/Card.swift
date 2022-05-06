import SwiftUI

public struct Card<Content: View, ReverseContent: View, Background: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @ViewBuilder var content: Content
    @ViewBuilder var reverseContent: ReverseContent
    @ViewBuilder var lightBackgroundContent: Background
    @ViewBuilder var darkBackgroundContent: Background
    
    var isReversible: Bool = false
    
    @State var backDegree = -90.0
    @State var frontDegree = 0.0
    @State var answerRevealed: Bool = false
    
    private var backgroundContent: Background {
        colorScheme == .dark ?
            darkBackgroundContent :
            lightBackgroundContent
    }
    
    func flip () {
        answerRevealed.toggle()
        
        if answerRevealed {
            withAnimation(.easeInOut(duration: CardConstants.FLIP_DURATION)) {
                frontDegree = -90
            }
            withAnimation(.easeInOut(duration: CardConstants.FLIP_DURATION).delay(CardConstants.FLIP_DELAY)){
                backDegree = 0
            }
        } else {
            withAnimation(.easeInOut(duration: CardConstants.FLIP_DURATION)) {
                backDegree = 90
            }
            withAnimation(.easeInOut(duration: CardConstants.FLIP_DURATION).delay(CardConstants.FLIP_DELAY)){
                frontDegree = 0
            }
        }
    }
    
    public var body: some View {
        Group {
            if isReversible {
                ZStack {
                    content.rotation3DEffect(Angle(degrees: frontDegree), axis: CardConstants.FLIP_ROTATION_AXIS)
                    reverseContent.rotation3DEffect(Angle(degrees: backDegree), axis: CardConstants.FLIP_ROTATION_AXIS)
                }
            }
            else {
                content
            }
        }
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
        .if(isReversible) { view in
            view.onTapGesture(perform: flip)
        }
    }
    
    public init(
        @ViewBuilder lightBackgroundBuilder: () -> Background,
        @ViewBuilder darkBackgroundBuilder: () -> Background,
        @ViewBuilder reverseContentBuilder: () -> ReverseContent,
        @ViewBuilder contentBuilder: () -> Content)
    {
        lightBackgroundContent = lightBackgroundBuilder()
        darkBackgroundContent = darkBackgroundBuilder()
        content = contentBuilder()
        reverseContent = reverseContentBuilder()
    }
}

public extension Card where Background == Color, ReverseContent == EmptyView {
    init(_ backgroundColorLight: Color = Color(.systemGray6),
         _ backgroundColorDark: Color = Color(.systemGray5),
         @ViewBuilder contentBuilder: () -> Content)
    {
        self.init(
            lightBackgroundBuilder: { backgroundColorLight },
            darkBackgroundBuilder: { backgroundColorDark }
        ) {
            contentBuilder()
        }
    }
}

public extension Card where ReverseContent == EmptyView {
    init(
        @ViewBuilder lightBackgroundBuilder: () -> Background,
        @ViewBuilder darkBackgroundBuilder: () -> Background,
        @ViewBuilder contentBuilder: () -> Content)
    {
        lightBackgroundContent = lightBackgroundBuilder()
        darkBackgroundContent = darkBackgroundBuilder()
        content = contentBuilder()
        reverseContent = EmptyView()
    }
}

public extension Card where Background == Color {
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

public extension Card {
    func reversible<NewReverseContent: View>(@ViewBuilder reverseContentBuilder: () -> NewReverseContent) -> some View {
        return Card<_, NewReverseContent, _> {
            self.lightBackgroundContent
        } darkBackgroundBuilder: {
            self.darkBackgroundContent
        } reverseContentBuilder: {
            reverseContentBuilder()
        } contentBuilder: {
            self.content
        }

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
            }.reversible { Text("Hello world!") }
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
