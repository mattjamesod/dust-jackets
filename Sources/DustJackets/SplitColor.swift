import SwiftUI

public struct SplitColor: View {
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

public extension Capsule where Background == SplitColor {
    init(@ViewBuilder contentBuilder: () -> Content)
    {
        self.init(backgroundBuilder: { SplitColor(Color(.systemGray6), .white, 1) }) {
            contentBuilder()
        }
    }

    func background(_ c1: Color, _ c2: Color = Color(.systemGray6), progress: CGFloat) -> some View {
        var updatedView = self
        updatedView.backgroundContent = SplitColor(c1, c2, progress)
        return updatedView
    }
}
//
//struct SplitColor_Previews: PreviewProvider {
//    static var previews: some View {
//        SplitColor(.red, .green, 0.3)
//    }
//}
//
//struct SplitColorCapsule_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            Capsule {
//                VStack(alignment: .leading) {
//                    Text("Hello World!")
//                    Text("Long Author Name")
//                        .font(.smallCaps(.subheadline)())
//                }
//                Spacer()
//                Image(systemName: "checkmark")
//            }.background(.red, .blue, progress: 0.3)
//            Capsule {
//                ListEntry(headline: "Hello World!")
//            }.background(.purple, progress: 0.7)
//            HStack {
//                Capsule {
//                    ListEntry(headline: "Hello World!")
//                }.background(.purple, progress: 0.7)
//                Capsule {
//                    ListEntry(headline: "Hello World!")
//                }.background(.purple, progress: 0.5)
//            }
//        }
//        .padding(.horizontal, 10)
//    }
//}
