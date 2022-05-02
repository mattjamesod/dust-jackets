import SwiftUI

struct NavigationBarModifier<ViewIdentifier: Comparable>: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    @Binding var selected: ViewIdentifier
    
    var options: [NavigationOption<ViewIdentifier>]
    
    private var backgroundContent: Color {
        colorScheme == .dark ?
        Color(.systemGray5) :
        Color(.systemGray6)
    }
    
    private var navItems: some View {
        HStack {
            ForEach(options) { option in
                Spacer()
                NavigationItem<ViewIdentifier>(details: option)
                    .onTapGesture {
                        selected = option.id as! ViewIdentifier
                        options.forEach { o in
                            o.update(selected)
                        }
                    }
            }
            Spacer()
        }
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
                navItems.padding(.bottom, 20)
            }
            .ignoresSafeArea()
            .frame(height: 70)
        }
    }
    
    init(_ selected: Binding<ViewIdentifier>, options: [NavigationOption<ViewIdentifier>]) {
        self._selected = selected
        self.options = options
        options.forEach { o in
            o.update(selected.wrappedValue)
        }
    }
}

extension View {
    func bottomNavBar<ViewIdentifier: Comparable>(
        _ selected: Binding<ViewIdentifier>,
        options: [NavigationOption<ViewIdentifier>]
    ) -> some View {
        self.modifier(NavigationBarModifier(selected, options: options))
    }
}

enum TestNavEnum: Comparable {
    case success
    case failure
}


struct BottomNavBar_Previews: PreviewProvider {
    @State static var selected: TestNavEnum = .failure
    
    static var options = [
        NavigationOption<TestNavEnum>(
            Image(systemName: "checkmark.circle"),
            selectedImage: Image(systemName: "checkmark.circle.fill"),
            id: .success),
        NavigationOption<TestNavEnum>(
            Image(systemName: "x.circle"),
            selectedImage: Image(systemName: "x.circle.fill"),
            id: .failure)
    ]
    
    static var previews: some View {
        Text("Hello world!")
            .bottomNavBar($selected, options: options)
        Text("Hello world!")
            .bottomNavBar($selected, options: options)
            .preferredColorScheme(.dark)
    }
}
