//
//  Advent of Code : Day 5
//
//  http://adventofcode.com/day/5

// Used so we can get access to the timing functions
import CoreFoundation

import Foundation

extension String {
    
    func containsRepeatingLetter() -> Bool {
        var lastChar: Character?
        for (_, char) in self.characters.enumerate() {
            if char == lastChar {
                return true
            }
            lastChar = char
        }
        return false
    }
    
    func containsMinimumOfThreeVowels() -> Bool {
        return rangeOfString("[aeiou].*[aeiou].*[aeiou]", options: .RegularExpressionSearch) != nil
    }
    
    func containsInvalidSequences() -> Bool {
        return rangeOfString("ab|cd|pq|xy", options: .RegularExpressionSearch) != nil
    }
    
    // Part 2
    
    func containsValidRepeatingPairs() -> Bool {
        return (rangeOfString("(..).*\\1", options: .RegularExpressionSearch) != nil && rangeOfString("(.).\\1", options: .RegularExpressionSearch) != nil)
    }
    
    
}

// Load in the puzzle input (switch to day5-quick to use a smaller set)
let input = try! String(contentsOfFile: Process.arguments[1], encoding: NSUTF8StringEncoding)

let startTime = CFAbsoluteTimeGetCurrent()

// Split the input
var strings = input.characters.split { $0 == "\n" }.map(String.init)

// Initialize our nice count
var niceCount = 0

// Iterate through our input
for (pos, string) in strings.enumerate() {
    
    // Part 1
//    if string.containsMinimumOfThreeVowels() &&
//        string.containsRepeatingLetter() &&
//        !string.containsInvalidSequences() {
//            niceCount++
//    }
    
    // Part 2
        if string.containsValidRepeatingPairs() {
            niceCount++
        }
}

let elapsed = (CFAbsoluteTimeGetCurrent() - startTime)

print("[\(elapsed)s | \(elapsed/60)m] \(niceCount) strings are nice!")

// day5
// p1 - [5.44962400197983s | 0.0908270666996638m] 258 strings are nice!
// p2 - [3.55411899089813s | 0.0592353165149689m] 53 strings are nice!
