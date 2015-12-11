//
//  Advent of Code : Day 2
//
//  http://adventofcode.com/day/2

import Foundation

struct XMMapPoint {
    var x: Int = 0
    var y: Int = 0
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    func key() -> String {
        return "\(x), \(y)"
    }
    
    mutating func move(direction: Character) -> String {
        switch direction {
        case "^": y++
        case ">": x++
        case "v": y--
        case "<": x--
        default: break
        }
        return "\(x), \(y)"
    }
}

// Load in the puzzle input (switch to day3-quick to use a smaller set)
let input = try! String(contentsOfFile: Process.arguments[1], encoding: NSUTF8StringEncoding)

let startTime = CFAbsoluteTimeGetCurrent()

// How we'll track the locations we've been to
var positions = [String: Bool]()

// Position of our Santas
var santaPosition = XMMapPoint(x: 0, y: 0)
var roboPosition = XMMapPoint(x: 0, y: 0)

// Count our starting position for Santa
positions[santaPosition.key()] = true
positions[roboPosition.key()] = true

// Loop through each character, adjust are position, and add it to our set
for (idx, item) in input.characters.enumerate() {
    if idx % 2 == 0 {
        positions[santaPosition.move(item)] = true
    } else {
        positions[roboPosition.move(item)] = true
    }
}

let elapsed = (CFAbsoluteTimeGetCurrent() - startTime)

print("[\(elapsed)s | \(elapsed/60)m] Total deliveries: \(positions.count)")

// Part 1
// [4.80325204133987s | 0.0800542006889979m] Total deliveries: 2081

// Part 2
// [4.90682399272919s | 0.0817803998788198m] Total deliveries: 2341