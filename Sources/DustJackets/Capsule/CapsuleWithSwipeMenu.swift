import SwiftUI

struct CapsuleWithSwipeMenu<Content: View>: View {
    @ViewBuilder var content: Content
    
    @GestureState var dragOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            Capsule {
                HStack {
                    Spacer()
                    Text("Hi!")
                }
            }.backgroundColor(.red)
            Capsule {
                content
            }
            .gesture(
                DragGesture()
                    .updating($dragOffset) { (value, dragOffset, transaction) in
                        dragOffset = value.location.x
                    }
            )
            .offset(x: -dragOffset)
        }
    }
}

struct CapsuleWithSwipeMenu_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CapsuleWithSwipeMenu {
                Text("Hello World!")
            }
        }.padding(.horizontal, 10)
    }
}
