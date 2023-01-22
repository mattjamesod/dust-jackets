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

extension EdgeInsets {
    var horizontal: CGFloat {
        self.leading + self.trailing
    }
    
    var vertical: CGFloat {
        self.top + self.bottom
    }
    
    init(vertical: CGFloat, horizontal: CGFloat) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
}
