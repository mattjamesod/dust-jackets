import SwiftUI

public extension AnyTransition {
    static var rotateX: AnyTransition {
        .modifier(
            active: RotateXModifier(angle: .radians(-.pi/2)),
            identity: RotateXModifier(angle: .zero)
        )
    }
}

internal struct RotateXModifier: ViewModifier {
    let angle: Angle
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(angle, axis: (x: 1, y: 0, z: 0))
    }
}
