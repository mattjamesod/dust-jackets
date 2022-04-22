import SwiftUI

public struct SliderCapsule<Content: View>: View, Identifiable {
    public var id: UUID = UUID()
    
    private var content: Content
    
    public var body: some View {
        Capsule {
            content
        }
    }
    
    public init(
        @ViewBuilder contentBuilder: () -> Content)
    {
        content = contentBuilder()
    }
}

struct SliderCapsule_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SliderCapsule {
                Text("Hello World!")
            }
            HStack {
                ForEach(0..<7) { n in
                    SliderCapsule {
                        Text(String(n))
                    }
                }
            }
            SliderCapsule {
                Text("We and our partners store and/or access information on a device, such as cookies and process personal data, such as unique identifiers.")
            }
            HStack {
                SliderCapsule {
                    Text("We and our partners store and/or access information on a device, such as cookies and process personal data, such as unique identifiers.")
                    Image(systemName: "checkmark")
                }
            }
        }
        .padding(.horizontal, 10)
        .previewInterfaceOrientation(.portrait)
    }
}
