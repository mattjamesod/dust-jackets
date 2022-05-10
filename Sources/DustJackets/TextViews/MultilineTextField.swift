import SwiftUI

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

public struct MultilineTextField: View {
    @Binding var text: String
    @State private var textEditorHeight: CGFloat = 100
    
    public var body: some View{
        ZStack(alignment: .topLeading) {
            Text(text)
                .background(GeometryReader {
                    Color.clear
                        .preference(key: ViewHeightKey.self,
                                           value: $0.frame(in: .local).size.height)

                })
                .opacity(0)
                .foregroundColor(Color.red)
                
            TextEditor(text: $text)
                .padding(EdgeInsets(top: -7, leading: -3, bottom: -5, trailing: -7))
                .frame(height: textEditorHeight + 12)
        }
        .onPreferenceChange(ViewHeightKey.self) { textEditorHeight = $0 }
    }
}
