import SwiftUI

public struct ItemCapsule<Content: View>: View {
    @ViewBuilder var content: Content
    
    private let MIN_HEIGHT: CGFloat = 60.0
    private let CORNER_RADIUS: CGFloat = 15.0
    private let BACKGROUND: Color = Color(.systemGray6)
    
    public var body: some View {
        HStack(spacing: 0) {
            content
                .padding(CORNER_RADIUS)
        }
        .frame(maxWidth: .infinity, minHeight: MIN_HEIGHT)
        .background(BACKGROUND)
        .cornerRadius(CORNER_RADIUS)
    }
}

struct Capsule_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ItemCapsule {
                Text("Hello World!")
            }
            ItemCapsule {
                Text("Hello World!")
                Spacer()
                Image(systemName: "checkmark")
            }
            HStack {
                ItemCapsule {
                    Text("Hello World!")
                }
                ItemCapsule {
                    Text("Hello World!")
                }
            }
            HStack {
                ForEach(0..<7) { n in
                    ItemCapsule {
                        Text(String(n))
                    }
                }
            }
            ItemCapsule {
                Text("We and our partners store and/or access information on a device, such as cookies and process personal data, such as unique identifiers.")
            }
            HStack {
                ItemCapsule {
                    Text("We and our partners store and/or access information on a device, such as cookies and process personal data, such as unique identifiers.")
                    Image(systemName: "checkmark")
                }
            }
        }
        .padding(.horizontal, 10)
    }
}
