import SwiftUI

public extension AnyTransition {
    static var rotateX: AnyTransition { rotate(x: .radians(-.pi/2)) }
    
    static func rotate(
        x: Angle = .zero,
        y: Angle = .zero,
        z: Angle = .zero
    ) -> AnyTransition {
        .modifier(
            active: RotateXModifier(angle: x),
            identity: RotateXModifier(angle: .zero)
        ).combined(with:
        .modifier(
            active: RotateYModifier(angle: y),
            identity: RotateYModifier(angle: .zero)
        )).combined(with:
        .modifier(
            active: RotateZModifier(angle: z),
            identity: RotateZModifier(angle: .zero)
        ))
    }
}

internal struct RotateXModifier: ViewModifier {
    let angle: Angle
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(angle, axis: (x: 1, y: 0, z: 0), anchor: .top)
    }
}

internal struct RotateYModifier: ViewModifier {
    let angle: Angle
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(angle, axis: (x: 0, y: 1, z: 0))
    }
}

internal struct RotateZModifier: ViewModifier {
    let angle: Angle
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(angle, axis: (x: 0, y: 0, z: 1))
    }
}
