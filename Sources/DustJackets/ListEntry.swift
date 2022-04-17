import SwiftUI

public struct ListEntry<Content: View>: View {
    @ViewBuilder var content: Content
    
    let headline: String
    let subline: String
    
    public var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(headline)
                if subline != "" {
                    Text(subline)
                        .font(.smallCaps(.subheadline)())
                }
            }
            Spacer()
            content
        }
    }
    
    public init(headline: String, subline: String = "", @ViewBuilder contentBuilder: () -> Content) {
        self.headline = headline
        self.subline = subline
        self.content = contentBuilder()
    }
}

extension ListEntry where Content == EmptyView {
    public init(headline: String, subline: String = "") {
        self.init(headline: headline, subline: subline, contentBuilder: {
            EmptyView()
        })
    }
}

internal struct ListEntryWithCheckmark: View {
    let headline: String
    let subline: String
    
    var body: some View {
        ListEntry(headline: headline,
                             subline: subline) {
            Image(systemName: "checkmark")
        }
    }
}

struct ListEntry_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 15) {
            ListEntry(headline: "This entry has no subline or content")
                .background(Color(.systemGray6))
            ListEntry(headline: "This entry has no subline or content but is really super duper long")
                .background(Color(.systemGray6))
            ListEntry(headline: "This entry has no subline") {
                Image(systemName: "square")
            }
            .background(Color(.systemGray6))
            ListEntry(headline: "This entry has no right content",
                                 subline: "This is an author name")
            .background(Color(.systemGray6))
            ListEntry(headline: "This is a title",
                                 subline: "This is an author name") {
                Image(systemName: "cross")
            }
            .background(Color(.systemGray6))
            ListEntryWithCheckmark(headline: "This is from a child view",
                                   subline: "(that always adds a tick)")
            .background(Color(.systemGray6))
        }
        .padding(.horizontal, 10)
    }
}