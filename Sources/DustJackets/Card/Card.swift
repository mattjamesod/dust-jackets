import SwiftUI

public struct Card<Content: View, ReverseContent: View>: View {
    @ViewBuilder var content: Content
    @ViewBuilder var reverseContent: ReverseContent
    
    var reverseAnimation: CardReverseAnimation = .none
    
    var isReversible: Bool = false
    var reverseOnContentTap: Bool = true
    var toExecuteOnReverse: ((Bool) -> ())? = nil
    
    public var color: Color
    
    @State var backDegree = -90.0
    @State var frontDegree = 0.0
    @State var answerRevealed: Bool = false
    
    func reverseFlip() {
        answerRevealed.toggle()
        
        if let toExecute = toExecuteOnReverse {
            toExecute(answerRevealed)
        }
        
        if answerRevealed {
            withAnimation(.easeInOut(duration: CardConstants.defaults.FLIP_DURATION)) {
                frontDegree = -90
            }
            withAnimation(.easeInOut(duration: CardConstants.defaults.FLIP_DURATION).delay(CardConstants.defaults.FLIP_DELAY)){
                backDegree = 0
            }
        } else {
            withAnimation(.easeInOut(duration: CardConstants.defaults.FLIP_DURATION)) {
                backDegree = 90
            }
            withAnimation(.easeInOut(duration: CardConstants.defaults.FLIP_DURATION).delay(CardConstants.defaults.FLIP_DELAY)){
                frontDegree = 0
            }
        }
    }
    
    func reverseNone() {
        answerRevealed.toggle()
        
        if let toExecute = toExecuteOnReverse {
            toExecute(answerRevealed)
        }
    }
    
    public var body: some View {
        Group {
            if isReversible && reverseOnContentTap && reverseAnimation == .flip {
                ZStack {
                    CardBase(contentBuilder: { content }, color: color)
                        .rotation3DEffect(Angle(degrees: frontDegree), axis: CardConstants.defaults.FLIP_ROTATION_AXIS)
                    CardBase(contentBuilder: { reverseContent }, color: color)
                        .rotation3DEffect(Angle(degrees: backDegree), axis: CardConstants.defaults.FLIP_ROTATION_AXIS)
                }
                .onTapGesture(perform: reverseFlip)
            }
            else if isReversible && !reverseOnContentTap && reverseAnimation == .flip {
                ZStack {
                    CardBase(contentBuilder: { content }, color: color, reverseMethod: reverseFlip)
                        .rotation3DEffect(Angle(degrees: frontDegree), axis: CardConstants.defaults.FLIP_ROTATION_AXIS)
                    CardBase(contentBuilder: { reverseContent }, color: color, reverseMethod: reverseFlip)
                        .rotation3DEffect(Angle(degrees: backDegree), axis: CardConstants.defaults.FLIP_ROTATION_AXIS)
                }
            }
            else if isReversible && reverseOnContentTap && reverseAnimation == .none {
                Group {
                    if !answerRevealed {
                        CardBase(contentBuilder: { content }, color: color)
                    }
                    else {
                        CardBase(contentBuilder: { reverseContent }, color: color)
                    }
                }
                .onTapGesture(perform: reverseNone)
            }
            else if isReversible && !reverseOnContentTap && reverseAnimation == .none {
                Group {
                    if !answerRevealed {
                        CardBase(contentBuilder: { content }, color: color, reverseMethod: reverseNone)
                    }
                    else {
                        CardBase(contentBuilder: { reverseContent }, color: color, reverseMethod: reverseNone)
                    }
                }
            }
            else {
                CardBase(contentBuilder: { content }, color: color)
            }
        }
    }
    

    
    public init(
        @ViewBuilder reverseContentBuilder: () -> ReverseContent,
        @ViewBuilder contentBuilder: () -> Content,
        color: Color)
    {
        content = contentBuilder()
        reverseContent = reverseContentBuilder()
        self.color = color
    }
}

public extension Card where ReverseContent == EmptyView {
    init(@ViewBuilder contentBuilder: () -> Content) {
        content = contentBuilder()
        reverseContent = EmptyView()
        self.color = Color(.systemGray5)
    }
    
    init(color: Color, @ViewBuilder contentBuilder: () -> Content) {
        content = contentBuilder()
        reverseContent = EmptyView()
        self.color = color
    }
}

public extension Card {
    func reversible<NewReverseContent: View>(
        onFlip: @escaping (Bool) -> () = { _ in },
        animation: CardReverseAnimation = .flip,
        includeContent: Bool = true,
        @ViewBuilder reverseContentBuilder: () -> NewReverseContent
    ) -> Card<Content, NewReverseContent> {
        
        var card = Card<_, NewReverseContent>(
            reverseContentBuilder: reverseContentBuilder,
            contentBuilder: { self.content },
            color: self.color
        )
        
        card.reverseAnimation = animation
        card.isReversible = true
        card.toExecuteOnReverse = onFlip
        card.reverseOnContentTap = includeContent
        return card
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
