import SwiftUI

public struct Capsule<Content: View>: View {
    private var content: Content
    private var background: Color = Color(.systemGray6)
    
    private let MIN_HEIGHT: CGFloat = 60.0
    private let CORNER_RADIUS: CGFloat = 15.0
    
    public var body: some View {
        HStack(spacing: 0) {
            content
                .padding(CORNER_RADIUS)
        }
        .frame(maxWidth: .infinity, minHeight: MIN_HEIGHT)
        .background(background)
        .cornerRadius(CORNER_RADIUS)
    }
    
    public init(@ViewBuilder contentBuilder: () -> Content) {
        content = contentBuilder()
    }
}

public extension Capsule {
    func backgroundColor(_ color: Color) -> some View {
        var updatedView = self
        updatedView.background = color
        return updatedView
    }
}

struct Capsule_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Capsule {
                Text("Hello World!")
            }
            Capsule {
                Text("Hello World!")
            }.backgroundColor(.red)
            Capsule {
                Text("Hello World!")
                Spacer()
                Image(systemName: "checkmark")
            }
            HStack {
                Capsule {
                    Text("Hello World!")
                }
                Capsule {
                    Text("Hello World!")
                }
            }
            HStack {
                ForEach(0..<7) { n in
                    Capsule {
                        Text(String(n))
                    }
                }
            }
            Capsule {
                Text("We and our partners store and/or access information on a device, such as cookies and process personal data, such as unique identifiers.")
            }
            HStack {
                Capsule {
                    Text("We and our partners store and/or access information on a device, such as cookies and process personal data, such as unique identifiers.")
                    Image(systemName: "checkmark")
                }
            }
        }
        .padding(.horizontal, 10)
    }
}
