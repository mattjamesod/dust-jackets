import SwiftUI

public struct Card<Content: View, ReverseContent: View, Background: View>: View {
    @ViewBuilder var content: Content
    @ViewBuilder var reverseContent: ReverseContent
    @ViewBuilder var lightBackgroundContent: Background
    @ViewBuilder var darkBackgroundContent: Background
    
    var isReversible: Bool = false
    
    @State var backDegree = -90.0
    @State var frontDegree = 0.0
    @State var answerRevealed: Bool = false
    
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
                    CardBase(lightBackgroundBuilder: {
                            lightBackgroundContent
                        }, darkBackgroundBuilder: {
                            darkBackgroundContent
                        }, contentBuilder: {
                            content
                        }
                    )
                    .rotation3DEffect(Angle(degrees: frontDegree), axis: CardConstants.FLIP_ROTATION_AXIS)
                    CardBase(lightBackgroundBuilder: {
                            lightBackgroundContent
                        }, darkBackgroundBuilder: {
                            darkBackgroundContent
                        }, contentBuilder: {
                            reverseContent
                        }
                    )
                    .rotation3DEffect(Angle(degrees: backDegree), axis: CardConstants.FLIP_ROTATION_AXIS)
                }
                .onTapGesture(perform: flip)
            }
            else {
                CardBase(lightBackgroundBuilder: {
                        lightBackgroundContent
                    }, darkBackgroundBuilder: {
                        darkBackgroundContent
                    }, contentBuilder: {
                        content
                    }
                )
            }
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
