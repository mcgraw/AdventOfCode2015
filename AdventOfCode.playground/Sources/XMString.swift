import Foundation

public extension String {
    
    var length: Int {
        return self.characters.count
    }
    
    subscript(i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
}