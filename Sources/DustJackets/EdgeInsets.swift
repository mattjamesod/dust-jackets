import SwiftUI

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
