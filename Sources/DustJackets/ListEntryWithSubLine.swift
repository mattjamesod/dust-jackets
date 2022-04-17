import SwiftUI

public struct ListEntryWithSubLine<Content: View>: View {
    @ViewBuilder var content: Content
    
    let headline: String
    let subline: String
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(headline)
            Text(subline)
                .font(.smallCaps(.subheadline)())
        }
        Spacer()
        content
    }
    
//    public init(headline: String, subline: String) {
//
//    }
}

//extension ListEntryWithSubLine {
//    func freestyle() -> some View {
//        var updatedView = self
//        updatedView.backgroundColor = color
//        return updatedView
//    }
//}
