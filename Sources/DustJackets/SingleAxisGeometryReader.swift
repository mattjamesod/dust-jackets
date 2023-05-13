import SwiftUI

//taken from: https://www.wooji-juice.com/blog/stupid-swiftui-tricks-single-axis-geometry-reader.html

public struct SingleAxisGeometryReader<Content: View>: View {
    private struct SizeKey: PreferenceKey {
        static var defaultValue: CGFloat { 10 }
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = max(value, nextValue())
        }
    }

    @State private var size: CGFloat = SizeKey.defaultValue

    var axis: Axis = .horizontal
    var alignment: Alignment = .center
    let content: (CGFloat) -> Content
    
    public init(
        direction: Axis = .horizontal,
        alignment: Alignment = .center,
        _ content: @escaping (CGFloat) -> Content)
    {
        self.axis = direction
        self.alignment = alignment
        self.content = content
    }

    public var body: some View {
        content(size)
            .frame(
                maxWidth:  axis == .horizontal ? .infinity : nil,
                maxHeight: axis == .vertical   ? .infinity : nil,
                alignment: alignment
            )
            .background(
                GeometryReader { geometry in
                    Color.clear.preference(
                        key: SizeKey.self,
                        value: axis == .horizontal ? geometry.size.width : geometry.size.height
                    )
                }
            )
            .onPreferenceChange(SizeKey.self) {
                size = $0
            }
    }
}
