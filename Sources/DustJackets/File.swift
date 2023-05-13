import Foundation

extension String {
    func urlSubstrings() -> [String] {
        let matcher = try! Regex("(http|ftp|https):\\/\\/([\\w_-]+(?:(?:\\.[\\w_-]+)+))([\\w.,@?^=%&:\\/~+#-]*[\\w@?^=%&\\/~+#-])")
        
        return self.ranges(of: matcher).map { String(self[$0]) }
    }
}
