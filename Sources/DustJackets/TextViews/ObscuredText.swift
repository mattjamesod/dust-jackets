import SwiftUI

struct ObscuredText: View {
    let pixelSize: Int = 4
    let pixelsPerColumn: Int = 3
    
    func pixelColor() -> Int {
        Int.random(in: 0...1) == 1 ? .primary : .clear
    }
    
    var pixel: some View {
        Rectangle()
            .frame(width: pixelSize, height: pixelSize)
            .foregroundColor(pixelColor())
    }
    
    var randomPixelColumn: some View {
        VStack(spacing: 0) {
            ForEach(1..<pixelsPerColumn) {
                pixel
            }
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 0) {
                ForEach(1..<Int(proxy.size.width/4), id:\.self) { index in
                    randomPixelColumn()
                }
            }
            .padding(.top, 8)
        }
        .frame(height: 20)
    }
}
