import SwiftUI

public struct CapsuleContainer<Content: View, ListContent: View>: View {
    private var content: Content
    private var items: ListContent
    
    private var backgroundColor: Color
    
    private let MIN_HEIGHT: CGFloat = 60.0
    private let CORNER_RADIUS: CGFloat = 15.0
    private let CONTAINER_PADDING: CGFloat = 7.5
    
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
                Group {
                    VStack(alignment: .leading) {
                        Text("The Way of Kings")
                        Text("Brandon Sanderson")
                            .font(.smallCaps(.subheadline)())
                    }
                    Spacer()
                    Image(systemName: "checkmark")
                }
                Group {
                    VStack(alignment: .leading) {
                        Text("Words of Radiance")
                        Text("Brandon Sanderson")
                            .font(.smallCaps(.subheadline)())
                    }
                    Spacer()
                    Image(systemName: "checkmark")
                }
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
                Group {
                    VStack(alignment: .leading) {
                        Text("The Way of Kings")
                        Text("Brandon Sanderson")
                            .font(.smallCaps(.subheadline)())
                    }
                    Spacer()
                    Image(systemName: "checkmark")
                }
                Group {
                    VStack(alignment: .leading) {
                        Text("Words of Radiance")
                        Text("Brandon Sanderson")
                            .font(.smallCaps(.subheadline)())
                    }
                    Spacer()
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
            Group {
                VStack(alignment: .leading) {
                    Text("The Final Empire")
                    Text("Brandon Sanderson")
                        .font(.smallCaps(.subheadline)())
                }
                Spacer()
                Image(systemName: "checkmark")
            }
            Group {
                VStack(alignment: .leading) {
                    Text("The Well of Ascension")
                    Text("Brandon Sanderson")
                        .font(.smallCaps(.subheadline)())
                }
                Spacer()
                Image(systemName: "checkmark")
            }
            Group {
                VStack(alignment: .leading) {
                    Text("The Hero of Ages")
                    Text("Brandon Sanderson")
                        .font(.smallCaps(.subheadline)())
                }
                Spacer()
                Image(systemName: "checkmark")
            }
        })
        .backgroundColor(.gray)
        .padding(.horizontal, 10)
    }
}
