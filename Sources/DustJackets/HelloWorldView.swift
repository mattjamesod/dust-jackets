import SwiftUI

public struct HelloWorldView<Content: View>: View {
    var content: Content
    
    public var body: some View {
        VStack {
            Text("Hello World! See user content:")
            content
        }
    }
    
    public init(@ViewBuilder contentBuilder: () -> Content) {
        content = contentBuilder()
    }
}
