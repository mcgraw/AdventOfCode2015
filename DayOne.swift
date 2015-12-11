//
//  Advent of Code : Day 1
//
//  http://adventofcode.com/day/1

import Foundation

// Load in the puzzle input
var input = try! String(contentsOfFile: Process.arguments[1], encoding: NSUTF8StringEncoding)

let startTime = CFAbsoluteTimeGetCurrent()

var floor = 0
var steps = 1
for c in input.characters {
    if c == "(" {
        floor++
    } else if c == ")" {
        floor--
    }
    
    // Part 2
    if floor == -1 {
        break
    }
    steps++
}

let elapsed = (CFAbsoluteTimeGetCurrent() - startTime)

print("[\(elapsed)s | \(elapsed/60)m] Floor \(floor), \(steps) steps")
