import SwiftUI

public extension View {
    func captureHeight(into someVariable: Binding<Double>) -> some View {
        self.background(GeometryReader { proxy in
            Task { @MainActor in
                guard someVariable.wrappedValue != proxy.size.height else { return }
                if someVariable.wrappedValue == 0 { someVariable.wrappedValue = proxy.size.height  }
                else { withAnimation { someVariable.wrappedValue = proxy.size.height } }
            }
            
            return Color.clear
        })
    }
}

public extension EdgeInsets {
    var horizontal: Double {
        self.leading + self.trailing
    }
    
    var vertical: Double {
        self.top + self.bottom
    }
    
    init(vertical: Double, horizontal: Double) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
}
