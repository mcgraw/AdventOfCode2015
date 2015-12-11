import Foundation

public extension String {
    
    var length: Int {
        return self.characters.count
    }
    
    subscript(i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (r: Range<Int>) -> String {
        get {
            return self[Range(start: startIndex.advancedBy(r.startIndex),
                                end: startIndex.advancedBy(r.endIndex - r.startIndex))]
        }
    }
}