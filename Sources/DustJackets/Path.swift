import SwiftUI

public extension Path {
    enum Corner: Int {
        case topRight = 0
        case topLeft = 1
        case bottomLeft = 2
        case bottomRight = 3
        
        var startAngle: Angle {
            .radians(-1 * CGFloat(self.rawValue) * (.pi / 2))
        }
        
        var endAngle: Angle {
            startAngle - .radians(.pi / 2)
        }
        
        func center(_ w: CGFloat, _ h: CGFloat, _ r: CGFloat) -> CGPoint {
            switch self {
            case .topRight:
                return CGPoint(x: w - r, y: r)
            case .topLeft:
                return CGPoint(x: r, y: r)
            case .bottomLeft:
                return CGPoint(x: r, y: h - r)
            case .bottomRight:
                return CGPoint(x: w - r, y: h - r)
            }
        }
    }
    
    mutating func roundedCorner(_ corner: Path.Corner, w: CGFloat, h: CGFloat, r: CGFloat) {
        self.addArc(
            center: corner.center(w, h, r),
            radius: r,
            startAngle: corner.startAngle,
            endAngle: corner.endAngle,
            clockwise: true
        )
    }
}
