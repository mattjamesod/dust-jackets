import SwiftUI

public struct SunkenCard<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @ViewBuilder var content: Content
    
    private var backgroundColor: Color {
        colorScheme == .dark ?
        Color(.systemGray3) : Color(.systemGray6)
    }
    
    private var screenColor: Color {
        colorScheme == .dark ?
            .black : .white
    }
    
    private var shadowColor: Color {
        colorScheme == .dark ?
            Color(.systemGray6) : .gray
    }
    
    var overlayView: some View {
        RoundedRectangle(cornerRadius: CardConstants.CORNER_RADIUS)
            .stroke(screenColor, lineWidth: 5)
            .shadow(color: shadowColor,
                    radius: CardConstants.SHADOW_RADIUS,
                    x: CardConstants.SHADOW_OFFSET,
                    y: CardConstants.SHADOW_OFFSET)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: CardConstants.CORNER_RADIUS
                )
            )
    }
    
    public var body: some View {
        content
            .padding(.vertical, CardConstants.CONTAINER_VERTICAL_PADDING)
            .padding(.horizontal, CardConstants.CONTAINER_HORIZONTAL_PADDING)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: CardConstants.CORNER_RADIUS)
                .foregroundColor(backgroundColor)
                .overlay(overlayView)
            )
    }
}

struct SunkenCard_Previews: PreviewProvider {
    static var example: some View {
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
    
    static var previews: some View {
        HStack {
            SunkenCard {
                example
            }
            Card {
                example
            }
        }
        .padding(.horizontal, 10)
        
        HStack {
            SunkenCard {
                example
            }
            Card {
                example
            }
        }
        .padding(.horizontal, 10)
        .preferredColorScheme(.dark)
    }
}
