import SwiftUI

public extension Path {
    enum Corner {
        case topRight
        case topLeft
        case bottomLeft
        case bottomRight
        
        var index: Int {
            switch self {
            case .topRight: return 0
            case .topLeft: return 1
            case .bottomLeft: return 2
            case .bottomRight: return 3
            }
        }
        
        var startAngle: Angle {
            .radians(-1 * CGFloat(self.index) * (.pi / 2))
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
        let r_clamped = r.clamped(to: 0...min(w,h)/2)
        
        return self.addArc(
            center: corner.center(w, h, r_clamped),
            radius: r_clamped,
            startAngle: corner.startAngle,
            endAngle: corner.endAngle,
            clockwise: true
        )
    }
    
    mutating func roundedCorner(start: Angle, end: Angle, center: CGPoint, r: CGFloat) {
        return self.addArc(
            center: center,
            radius: r,
            startAngle: start,
            endAngle: end,
            clockwise: true
        )
    }
}
