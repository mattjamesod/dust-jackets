import SwiftUI

public struct Capsule<Content: View>: View, Identifiable {
    public var id: UUID = UUID()
    
    private var content: Content
    private var backgroundColor: Color
    
    private let MIN_HEIGHT: CGFloat = CapsuleConstants.MIN_HEIGHT
    private let CORNER_RADIUS: CGFloat = CapsuleConstants.CORNER_RADIUS
    
    public var body: some View {
        HStack(spacing: 0) {
            content
        }
        .padding(CORNER_RADIUS)
        .frame(maxWidth: .infinity, minHeight: MIN_HEIGHT)
        .background(backgroundColor)
        .cornerRadius(CORNER_RADIUS)
    }
    
    public init(
        _ background: Color = Color(.systemGray6),
        @ViewBuilder contentBuilder: () -> Content)
    {
        backgroundColor = background
        content = contentBuilder()
    }
}

public extension Capsule {
    func backgroundColor(_ color: Color) -> some View {
        var updatedView = self
        updatedView.backgroundColor = color
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
                Spacer()
                Image(systemName: "checkmark")
            }
            Capsule {
                VStack(alignment: .leading) {
                    Text("Hello World!")
                    Text("Long Author Name")
                        .font(.smallCaps(.subheadline)())
                }
                Spacer()
                Image(systemName: "checkmark")
            }
            Capsule {
                VStack(alignment: .leading) {
                    Text("Hello World!")
                    Text("super duper extra pro extra Long Author Name")
                        .font(.smallCaps(.subheadline)())
                }
                Spacer()
                Image(systemName: "checkmark")
            }
            Capsule {
                Text("Hello World!")
            }.backgroundColor(.red)
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
        .previewInterfaceOrientation(.portrait)
    }
}
