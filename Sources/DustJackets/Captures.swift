import SwiftUI

public extension View {
    func captureHeight(into someVariable: Binding<Double>) -> some View {
        self.background(GeometryReader { proxy in
            Task { @MainActor in
                try await Task.sleep(for: .milliseconds(170))
                
                guard someVariable.wrappedValue != proxy.size.height else { return }
                
                withAnimation {
                    someVariable.wrappedValue = proxy.size.height
                }
            }
            
            return Color.clear
        })
    }
    
    
    func captureWidth(into someVariable: Binding<Double>) -> some View {
        self.background(GeometryReader { proxy in
            Task { @MainActor in
                try await Task.sleep(for: .milliseconds(170))
                
                guard someVariable.wrappedValue != proxy.size.width else { return }
                
                withAnimation {
                    someVariable.wrappedValue = proxy.size.width
                }
            }
            
            return Color.clear
        })
    }
}
