import SwiftUI

public struct PopupMenu<Content: View, Label: View>: View {
    
    let content: () -> Content
    let label: () -> Label
    
    @State var popover: Bool = false
    
    public init(_ content: @escaping () -> Content, label: @escaping () -> Label) {
        self.content = content
        self.label = label
    }
    
    public var body: some View {
        #if os(macOS)
        label().popover(isPresented: $popover) {
            content()
        }
        .onTapGesture {
            withAnimation {
                popover.toggle()
            }
        }
        #else
        Menu(content: self.content, label: self.label)
            .menuStyle(.button)
        #endif
    }
}
