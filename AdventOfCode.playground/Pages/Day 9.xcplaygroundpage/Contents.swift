

import Foundation

// Helper function to build the required range for the regex element
func buildRangeFromLine(input: String, range: NSRange) -> Range<String.CharacterView.Index> {
    if range.location == NSNotFound {
        return input.endIndex..<input.endIndex
    }
    return Range(start: input.startIndex.advancedBy(range.location), end: input.startIndex.advancedBy(range.location + range.length))
}

struct XMNode {
    
    var node = [XMNode]()
    
    var value = 0
}

// The regex we'll use to pull each part of the instruction
var regex = try! NSRegularExpression(pattern: "(\\w*) to (\\w*) = ([0-9]*)", options: .CaseInsensitive)

// Load in the puzzle input (switch to day5-quick to use a smaller set)
let input = XMFileManager.shared.loadStringInputFromResource("day9")

input.enumerateLines { (line, stop) -> () in
 
    // Break up the given instruction into the necessary components
    let matches = regex.matchesInString(line, options: [], range: NSMakeRange(0, line.length))[0]
    
    // Location parts
    let c1 = line[buildRangeFromLine(line, range: matches.rangeAtIndex(1))]
    let c2 = line[buildRangeFromLine(line, range: matches.rangeAtIndex(2))]
    let value = line[buildRangeFromLine(line, range: matches.rangeAtIndex(3))]
 
    print("\(c1), \(c2), \(value)")
}