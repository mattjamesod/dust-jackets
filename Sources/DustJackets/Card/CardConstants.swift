import SwiftUI

open class CardConstants {
    public static var defaults: CardConstants = CardConstants()
    
    var CORNER_RADIUS: CGFloat { 7.5 }
    var CONTAINER_VERTICAL_PADDING: CGFloat { 7.5 }
    var CONTAINER_HORIZONTAL_PADDING: CGFloat { 15 }
    var SHADOW_RADIUS: CGFloat { 3 }
    var SHADOW_OFFSET: CGFloat { 1.5 }
    
    var FLIP_ROTATION_AXIS: (x: CGFloat, y: CGFloat, z: CGFloat) { (x: 1, y: 1, z: 0) }
    var FLIP_DURATION: CGFloat { 0.15 }
    var FLIP_DELAY: CGFloat { 0.15 }
    
    public init() {}
}
