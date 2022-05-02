import SwiftUI

struct NavigationItem<T>: View where T: Comparable {
    @ObservedObject var details: NavigationOption<T>
    
    var body: some View {
        VStack(spacing:2) {
            details.image
                .font(.bold(.title)())
            if let caption = details.caption {
                Text(caption)
                    .font(.caption)
            }
        }
    }
}

struct NavigationItem_Previews: PreviewProvider {
    @State static var selected: TestNavEnum = .success
    
    static var options = [
        NavigationOption<TestNavEnum>(Image(systemName: "checkmark"), id: .success),
        NavigationOption<TestNavEnum>(Image(systemName: "x.circle"), id: .failure)
    ]
    
    static var previews: some View {
        Text("Hello world!")
            .bottomNavBar($selected, options: options)
        NavigationItem(details: options[0])
    }
}
