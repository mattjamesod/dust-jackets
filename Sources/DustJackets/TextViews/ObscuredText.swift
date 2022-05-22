import SwiftUI

public struct ObscuredText: View {
    let pixelSize: Int
    let pixelsPerColumn: Int
    
    func pixelColor() -> Color {
        Int.random(in: 0...1) == 1 ? .primary : .clear
    }
    
    var pixel: some View {
        Rectangle()
            .frame(width: CGFloat(pixelSize), height: CGFloat(pixelSize))
            .foregroundColor(pixelColor())
    }
    
    var randomPixelColumn: some View {
        VStack(spacing: 0) {
            ForEach(1..<pixelsPerColumn, id:\.self) { _ in
                pixel
            }
        }
    }
    
    public var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 0) {
                ForEach(1..<Int(proxy.size.width/4), id:\.self) { index in
                    randomPixelColumn
                }
            }
            .padding(.top, 8)
        }
        .frame(height: 20)
    }
    
    public init(pixelSize: Int = 4, pixelsPerColumn: Int = 3) {
        self.pixelSize = pixelSize
        self.pixelsPerColumn = pixelsPerColumn
    }
}
