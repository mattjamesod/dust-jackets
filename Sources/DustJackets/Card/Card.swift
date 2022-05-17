import SwiftUI

public struct Card<Content: View, ReverseContent: View>: View {
    @ViewBuilder var content: Content
    @ViewBuilder var reverseContent: ReverseContent
    
    var isReversible: Bool = false
    var toExecuteOnFlip: ((Bool) -> ())? = nil
    
    @State var backDegree = -90.0
    @State var frontDegree = 0.0
    @State var answerRevealed: Bool = false
    
    func flip () {
        answerRevealed.toggle()
        
        if let toExecute = toExecuteOnFlip {
            toExecute(answerRevealed)
        }
        
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
                    CardBase(contentBuilder: { content })
                        .rotation3DEffect(Angle(degrees: frontDegree), axis: CardConstants.FLIP_ROTATION_AXIS)
                    CardBase(contentBuilder: { reverseContent })
                        .rotation3DEffect(Angle(degrees: backDegree), axis: CardConstants.FLIP_ROTATION_AXIS)
                }
                .onTapGesture(perform: flip)
            }
            else {
                CardBase(contentBuilder: { content })
            }
        }
    }
    
    public init(
        @ViewBuilder reverseContentBuilder: () -> ReverseContent,
        @ViewBuilder contentBuilder: () -> Content)
    {
        content = contentBuilder()
        reverseContent = reverseContentBuilder()
    }
}

public extension Card where ReverseContent == EmptyView {
    init(@ViewBuilder contentBuilder: () -> Content) {
        content = contentBuilder()
        reverseContent = EmptyView()
    }
}

public extension Card {
    func reversible<NewReverseContent: View>(
        onFlip : @escaping (Bool) -> () = { _ in },
        @ViewBuilder reverseContentBuilder: () -> NewReverseContent
    ) -> Card<Content, NewReverseContent> {
        var card = Card<_, NewReverseContent>(
            reverseContentBuilder: reverseContentBuilder,
            contentBuilder: { self.content }
        )
            
        card.isReversible = true
        card.toExecuteOnFlip = onFlip
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
