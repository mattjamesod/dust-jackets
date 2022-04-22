import SwiftUI

public struct HorizontalBinaryColorView: View {
    private var c1: Color
    private var c2: Color
    private var divide: CGFloat

    public var body: some View {
        SingleAxisGeometryReader { width in
            HStack(spacing:0) {
                c1.frame(width: width * divide)
                c2
            }
        }
    }

    public init(_ c1: Color, _ c2: Color, _ divide: CGFloat) {
        self.c1 = c1
        self.c2 = c2
        self.divide = divide
    }
}

struct HorizontalBinaryColorView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalBinaryColorView(.red, .green, 0.3)
    }
}

struct BinaryColorCapsule_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Capsule {
                VStack(alignment: .leading) {
                    Text("Hello World!")
                    Text("Long Author Name")
                        .font(.smallCaps(.subheadline)())
                }
                Spacer()
                Image(systemName: "checkmark")
            }.background(.red, .blue, progress: 0.3)
            Capsule {
                VStack(alignment: .leading) {
                    Text("Hello World!")
                    Text("Long Author Name")
                        .font(.smallCaps(.subheadline)())
                }
                Spacer()
                Image(systemName: "checkmark")
            }.background(.purple, progress: 0.7)
        }
        .padding(.horizontal, 10)
    }
}
