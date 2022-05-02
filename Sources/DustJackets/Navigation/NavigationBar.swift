import SwiftUI

struct NavigationBarModifier<NavItemsContent: View>: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var navItems: NavItemsContent
    
    private var backgroundContent: Color {
        colorScheme == .dark ?
        Color(.systemGray5) :
        Color(.systemGray6)
    }
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            Spacer()
            content
            Spacer()
            ZStack {
                backgroundContent
                    .if(colorScheme == .light) { view in
                        view.shadow(
                            color: .gray,
                            radius: CardConstants.SHADOW_RADIUS+2,
                            x: CardConstants.SHADOW_OFFSET,
                            y: CardConstants.SHADOW_OFFSET-2
                        )
                    }
                navItems
            }
            .ignoresSafeArea()
            .frame(height: 60)
        }
    }
    
    init(@ViewBuilder _ navItems: () -> NavItemsContent) {
        self.navItems = navItems()
    }
}

extension View {
    func bottomNavBar<NavItemsContent: View>(
        @ViewBuilder _ navItems: () -> NavItemsContent
    ) -> some View {
        self.modifier(NavigationBarModifier(navItems))
    }
}

struct BottomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello world!")
            .bottomNavBar {
                HStack(alignment: .bottom) {
                    Spacer()
                    NavigationItem(systemImage: "checkmark")
                    Spacer()
                    NavigationItem(systemImage: "x.circle")
                    Spacer()
                }
            }
        Text("Hello world!")
            .bottomNavBar {
                HStack(alignment: .bottom) {
                    Spacer()
                    NavigationItem(systemImage: "checkmark", text: "success")
                    Spacer()
                    NavigationItem(systemImage: "x.circle", text: "failure")
                    Spacer()
                }
            }
            .preferredColorScheme(.dark)
    }
}
