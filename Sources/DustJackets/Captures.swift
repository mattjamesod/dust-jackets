import SwiftUI

public extension View {
    func captureHeight(into someVariable: Binding<Double>) -> some View {
        self.background(GeometryReader { proxy in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.17) {
                guard someVariable.wrappedValue != proxy.size.height else { return }
                if someVariable.wrappedValue == 0 { someVariable.wrappedValue = proxy.size.height  }
                else { withAnimation { someVariable.wrappedValue = proxy.size.height } }
            }
            
            return Color.clear
        })
    }
}
