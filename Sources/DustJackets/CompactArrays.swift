import Foundation

public extension Array {
    func compact<T>() -> [T] where Element == Optional<T> {
        self.compactMap { $0 }
    }
}
