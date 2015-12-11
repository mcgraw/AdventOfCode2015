//
//  Advent of Code : Day 8
//
//  http://adventofcode.com/day/8


import Foundation

public extension String {
    var length: Int {
        return self.characters.count
    }
}

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

// Load in the puzzle input
let input = try! String(contentsOfFile: Process.arguments[1], encoding: NSUTF8StringEncoding)

// The regex we'll use to pull each part of the instruction
var regex = try! NSRegularExpression(pattern: "(\\w*) to (\\w*) = ([0-9]*)", options: .CaseInsensitive)

let startTime = CFAbsoluteTimeGetCurrent()

input.enumerateLines { (line, stop) -> () in
    
    // Break up the given instruction into the necessary components
    let matches = regex.matchesInString(line, options: [], range: NSMakeRange(0, line.length))[0]
    
    // Location parts
    let c1 = line[buildRangeFromLine(line, range: matches.rangeAtIndex(1))]
    let c2 = line[buildRangeFromLine(line, range: matches.rangeAtIndex(2))]
    let value = line[buildRangeFromLine(line, range: matches.rangeAtIndex(3))]
    
    print("\(c1), \(c2), \(value)")
    
    
}


let elapsed = (CFAbsoluteTimeGetCurrent() - startTime)

print("[\(elapsed)s | \(elapsed/60)m]")


// Part 1:
// Part 2:


