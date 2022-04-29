import SwiftUI

struct InnerShadow<Content: View>: View {
    @ViewBuilder var content: Content
    
    var overlayView: some View {
        RoundedRectangle(cornerRadius: CardConstants.CORNER_RADIUS)
            .stroke(.white, lineWidth: 5)
            .shadow(color: .gray,
                    radius: CardConstants.SHADOW_RADIUS,
                    x: CardConstants.SHADOW_OFFSET,
                    y: CardConstants.SHADOW_OFFSET)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: CardConstants.CORNER_RADIUS
                )
            )
    }
    
    var body: some View {
        content
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: CardConstants.CORNER_RADIUS)
                .foregroundColor(Color(.systemGray6))
                .overlay(overlayView)
            )
    }
}

struct InnerShadow_Previews: PreviewProvider {
    static var previews: some View {
        InnerShadow {
            Text("Hello world!")
        }
        .frame(width: 250, height: 250)
        InnerShadow {
            Text("Hello world!")
        }
        .frame(width: 250, height: 250)
        .preferredColorScheme(.dark)
    }
}
