import SwiftUI

@resultBuilder struct CapsuleBuilder {
    static func buildBlock() -> EmptyView { EmptyView() }
    
    static func buildBlock<C0>(_ c0: C0)
        -> Capsule<C0> where C0 : View {
            Capsule(.white) { c0 }
    }
    
    static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1)
        -> TupleView<(Capsule<C0>, Capsule<C1>)> where C0 : View, C1 : View {
            TupleView((Capsule(.white) { c0 }, Capsule(.white) { c1 }))
    }
    
    static func buildBlock<C0, C1, C2>(_ c0: C0, _ c1: C1, _ c2: C2)
        -> TupleView<(Capsule<C0>, Capsule<C1>, Capsule<C2>)> where C0 : View, C1 : View, C2 : View {
            TupleView((Capsule(.white) { c0 }, Capsule(.white) { c1 }, Capsule(.white) { c2 }))
    }
    
    static func buildBlock<C0, C1, C2, C3>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3)
        -> TupleView<(Capsule<C0>, Capsule<C1>, Capsule<C2>, Capsule<C3>)> where C0 : View, C1 : View, C2 : View, C3 : View {
            TupleView((Capsule(.white) { c0 }, Capsule(.white) { c1 }, Capsule(.white) { c2 }, Capsule(.white) { c3 }))
    }
}
