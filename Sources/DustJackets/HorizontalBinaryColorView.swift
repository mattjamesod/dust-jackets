import SwiftUI

public struct HorizontalBinaryColorView: View {
    private var c1: Color
    private var c2: Color
    private var divide: CGFloat
    
    public var body: some View {
        SingleAxisGeometryReader { width in
            self.background(
                HStack(spacing:0) {
                    c1.frame(width: width * divide)
                    c2
                }
            )
        }
    }
    
    public init(_ c1: Color, _ c2: Color, _ divide: CGFloat) {
        self.c1 = c1
        self.c2 = c2
        self.divide = divide
    }
}

public extension Capsule where Background == HorizontalBinaryColorView {
    init(@ViewBuilder contentBuilder: () -> Content)
    {
        self.init(backgroundBuilder: { HorizontalBinaryColorView(Color(.systemGray6), .white, 1) }) {
            contentBuilder()
        }
    }
    
    func background(_ c1: Color, _ c2: Color, divide: CGFloat) -> some View {
        var updatedView = self
        updatedView.backgroundContent = HorizontalBinaryColorView(c1, c2, divide)
        return updatedView
    }
}

struct BinaryColorCapsule_Previews: PreviewProvider {
    static var previews: some View {
        Capsule {
            VStack(alignment: .leading) {
                Text("Hello World!")
                Text("Long Author Name")
                    .font(.smallCaps(.subheadline)())
            }
            Spacer()
            Image(systemName: "checkmark")
        }.background(.red, .blue, divide: 0.3)
    }
}
