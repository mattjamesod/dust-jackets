import SwiftUI

struct Card<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @ViewBuilder var content: Content
    
    private var backgroundColor: Color {
        colorScheme == .dark ? Color(.systemGray6) : .white
    }
    
    var body: some View {
        content
            .padding(.vertical, 7.5)
            .padding(.horizontal, 15)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(7.5)
            .if(colorScheme == .light) { view in
                view.shadow(color: .gray, radius: 5, x: 5, y: 5)
            }
    }
}

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

struct Card_Previews: PreviewProvider {
    
    static var columns: [GridItem] =
             Array(repeating: .init(.flexible()), count: 2)
    
    static var previews: some View {
        LazyVGrid(columns: columns) {
            Card {
                VStack {
                    HStack {
                        Text("Manana")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    HStack {
                        Text("Morning")
                        Spacer()
                    }
                }            }
            Card {
                VStack {
                    HStack {
                        Text("Perro")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    HStack {
                        Text("Dog")
                        Spacer()
                    }
                }
            }
        }
        .preferredColorScheme(.light)
        .padding(.horizontal, 10)
        LazyVGrid(columns: columns) {
            Card {
                VStack {
                    HStack {
                        Text("Manana")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    HStack {
                        Text("Morning")
                        Spacer()
                    }
                }            }
            Card {
                VStack {
                    HStack {
                        Text("Perro")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    HStack {
                        Text("Dog")
                        Spacer()
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
        .padding(.horizontal, 10)
    }
}
