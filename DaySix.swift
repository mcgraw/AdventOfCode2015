//
//  Advent of Code : Day 6
//
//  http://adventofcode.com/day/6

import CoreGraphics

// Used to access NSCharacterSet
import Foundation

// Used so we can get access to the timing functions
import CoreFoundation

// Load in the puzzle input
let input = try! String(contentsOfFile: Process.arguments[1], encoding: NSUTF8StringEncoding)

// Split the input
var strings = input.componentsSeparatedByString("\n")

let startTime = CFAbsoluteTimeGetCurrent()

var lights = Array(count: 1000, repeatedValue: Array(count: 1000, repeatedValue: 0))
var brightness = Array(count: 1000, repeatedValue: Array(count: 1000, repeatedValue: 0))

var on = 0
var bright = 0

for (idx, instruction) in strings.enumerate() {
    
    let separators = NSCharacterSet(charactersInString: " ,")
    let parts = instruction.componentsSeparatedByCharactersInSet(separators)
    
    let isToggle = (parts[0] == "toggle") ? true : false
    let x1 = isToggle ? Int(parts[1])! : Int(parts[2])!
    let x2 = isToggle ? Int(parts[2])! : Int(parts[3])!
    let y1 = isToggle ? Int(parts[4])! : Int(parts[5])!
    let y2 = isToggle ? Int(parts[5])! : Int(parts[6])!
    
    for var x = x1; x <= y1; x++ {
        
        for var y = x2; y <= y2; y++ {
            
            if isToggle {
                lights[x][y] = (lights[x][y] == 1) ? 0 : 1
                brightness[x][y] += 2
            } else {
                if parts[1] == "on" {
                    brightness[x][y] += 1
                } else {
                    brightness[x][y] += (brightness[x][y] > 0) ? -1 : 0
                }
                
                lights[x][y] = (parts[1] == "on") ? 1 : 0
            }
            
        }
        
    }
    
    print("Progress! Line \(idx+1) of \(strings.count) done")
}

for var x = 0; x < 1000; x++ {
    for var y = 0; y < 1000; y++ {
        on += lights[x][y]
        bright += brightness[x][y]
    }
}

let elapsed = (CFAbsoluteTimeGetCurrent() - startTime)

print("[\(elapsed)s | \(elapsed/60)m] \(on) lights were turned on with a brightness of \(bright)")