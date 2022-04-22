import SwiftUI

public struct CapsuleContainer<Content: View, ListContent: View>: View {
    private var content: Content
    private var items: ListContent
    
    private var backgroundColor: Color
    
    private let MIN_HEIGHT: CGFloat = CapsuleConstants.MIN_HEIGHT
    private let CONTAINER_PADDING: CGFloat = CapsuleConstants.CONTAINER_PADDING
    private let CORNER_RADIUS: CGFloat = CapsuleConstants.CORNER_RADIUS + CapsuleConstants.CONTAINER_PADDING
    
    public var body: some View {
        VStack(spacing: CONTAINER_PADDING) {
            HStack(spacing: 0) {
                content.frame(maxWidth: .infinity, minHeight: MIN_HEIGHT)
            }
            items
        }
        .padding(CONTAINER_PADDING)
        .background(backgroundColor)
        .cornerRadius(CORNER_RADIUS)
    }
    
    public init(_ background: Color = Color(.systemGray6),
                @ViewBuilder mainContent: () -> Content,
                @CapsuleBuilder listItems: () -> ListContent) {
        self.backgroundColor = background
        self.content = mainContent()
        self.items = listItems()
    }
}

public extension CapsuleContainer {
    func backgroundColor(_ color: Color) -> some View {
        var updatedView = self
        updatedView.backgroundColor = color
        return updatedView
    }
}

struct CapsuleContainer_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CapsuleContainer (mainContent: {
                Text("Main content, no items")
            }, listItems: { })
            CapsuleContainer (mainContent: {
            }, listItems: {
                ListEntry(headline: "The Way of Kings",
                          subline: "Brandon Sanderson") {
                    Image(systemName: "checkmark")
                }
                ListEntry(headline: "Words of Radiance",
                          subline: "Brandon Sanderson")
            })
            CapsuleContainer (mainContent: {
                Text("One item")
            }, listItems: {
                Text("I am the item")
            }).backgroundColor(.purple)
            CapsuleContainer(mainContent: {
                VStack {
                    Text("The Stormlight Archive")
                        .font(.bold(.title2)())
                    Text("Brandon Sanderson")
                        .font(.smallCaps(.subheadline)())
                }
            }, listItems: {
                ListEntry(headline: "The Way of Kings",
                          subline: "Brandon Sanderson") {
                    Image(systemName: "checkmark")
                }
                ListEntry(headline: "Words of Radiance",
                          subline: "Brandon Sanderson") {
                    Image(systemName: "checkmark")
                }
            })
            .backgroundColor(.blue)
        }
        .padding(.horizontal, 10)
        CapsuleContainer(mainContent: {
            VStack {
                Text("Mistborn, Era 1")
                    .font(.bold(.title2)())
                Text("Brandon Sanderson")
                    .font(.smallCaps(.subheadline)())
            }
        }, listItems: {
            ListEntry(headline: "The Final Empire",
                      subline: "Brandon Sanderson") {
                Image(systemName: "checkmark")
            }
            ListEntry(headline: "The Well of Ascension",
                      subline: "Brandon Sanderson") {
                Image(systemName: "checkmark")
            }
            ListEntry(headline: "The Hero of Ages",
                      subline: "Brandon Sanderson") {
                Image(systemName: "checkmark")
            }
        })
        .backgroundColor(.gray)
        .padding(.horizontal, 10)
    }
}
