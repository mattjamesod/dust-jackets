import SwiftUI

extension FloatingPoint {
    func clamped(to range: ClosedRange<Self>) -> Self {
        return max(min(self, range.upperBound), range.lowerBound)
    }
}

public struct CapsuleSlider<Content: View>: View, Identifiable {
    public var id: UUID = UUID()
    private var content: Content
    
    // always between 0 and 1
    @State var sliderPosition: CGFloat
    
    public var body: some View {
        SingleAxisGeometryReader { width in
            Capsule {
                content
            }
            .background(.blue, progress: sliderPosition)
            .gesture(DragGesture()
                .onChanged { value in
                    sliderPosition = (value.location.x / width)
                        .clamped(to: 0.0...1.0)
                }
                .onEnded { value in
                    // send to publisher
                }
            )
        }
    }
    
    public init(
        _ initialValue: CGFloat = 0,
        @ViewBuilder contentBuilder: () -> Content)
    {
        _sliderPosition = .init(
            initialValue: initialValue
                .clamped(to: 0.0...1.0)
        )
        content = contentBuilder()
    }
}

struct CapsuleSlider_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CapsuleSlider(12) {
                Text("Hello World!")
            }
            CapsuleSlider(0.87) {
                Text("We and our partners store and/or access information on a device, such as cookies and process personal data, such as unique identifiers.")
            }
            HStack {
                CapsuleSlider(0.2) {
                    Text("We and our partners store and/or access information on a device, such as cookies and process personal data, such as unique identifiers.")
                    Image(systemName: "checkmark")
                }
            }
        }
        .padding(.horizontal, 10)
        .previewInterfaceOrientation(.portrait)
    }
}
