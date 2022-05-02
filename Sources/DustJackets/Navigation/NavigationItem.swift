import SwiftUI

struct NavigationItem: View {
    var systemImage: String
    var text: String? = nil
    
    var body: some View {
        VStack(spacing:2) {
            Image(systemName: systemImage)
                .font(.system(size: 22))
            if let givenText = text {
                Text(givenText)
                    .font(.system(size: 10))
            }
        }
//        .foregroundColor(activeView == details.desiredView ? .primary : Color(.systemGray2))
//        .onTapGesture {
//            activeView = details.desiredView
//        }
    }
}

struct NavigationItem_Previews: PreviewProvider {
    static var previews: some View {
        NavigationItem(systemImage: "checkmark", text: "Success")
    }
}
