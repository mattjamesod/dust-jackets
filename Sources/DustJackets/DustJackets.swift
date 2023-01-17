import SwiftUI

public extension View {
    func captureHeight(into someVariable: Binding<Double>) -> some View {
        self.background(GeometryReader { proxy in
            Color.clear
                .onAppear {
                    someVariable.wrappedValue = proxy.size.height
                }
        })
    }
}

public struct DustJackets {
    
}
