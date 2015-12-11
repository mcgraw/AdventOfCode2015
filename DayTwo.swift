//
//  Advent of Code : Day 2
//
//  http://adventofcode.com/day/2

import Foundation

/* Small helper function to calculate square feet and ribbon (part 2)
*
*      Part 1: Perfect right rectangular prism
*              2*l*w + 2*w*h + 2*h*l
*
*              2x3x4
*              2*6 + 2*12 + 2*8 = 52 square feet
*
*      Part 2: Smallest perimeter of any one face
*
*/
func calculateHappiness(length l: Int, width w: Int, height h: Int) -> (sqft: Int, ribbon: Int) {
    let sqft = (2 * l * w) + (2 * w * h) + (2 * h * l)
    
    let d = [l, w, h].sort { $0 < $1 }
    var ribbon = d[0] + d[0] + d[1] + d[1]
    ribbon += l * w * h
    
    return (sqft, ribbon)
}

// Load in the puzzle input (switch to day2-quick to use a smaller set)
let input = try! String(contentsOfFile: Process.arguments[1], encoding: NSUTF8StringEncoding)

let startTime = CFAbsoluteTimeGetCurrent()

// Let's first break up the input into each present dimension
var dimensions = input.componentsSeparatedByString("\n")

// Part 2: Calculcate the feet of ribbon required
var totalFeetOfRibbon = 0

// Cycle through each dimension to calculate the square feet needed to wrap the present
let calculated = dimensions.map { (var dimension) -> Int in
    
    // Cycle through the diminsions to split it into the neccisary l, w, h
    let value = dimension.characters.split { $0 == "x" }.map(String.init)
    if let l = Int(value[0]), w = Int(value[1]), h = Int(value[2]) {
        var (sqft, ribbon) = calculateHappiness(length: l, width: w, height: h)
        
        // Track ribbon length
        totalFeetOfRibbon += ribbon
        
        // Don't forget to add a little extra paper (the smallest side area)
        let slack = min(l*w, w*h, h*l)
        
        return sqft + slack
    }
    return -1 // something went wrong
}

// Now calculate the paper required from each present (+ slack)
let totalPaperRequired = calculated.reduce(0, combine: {$0 + $1})

// day2.txt       == 1598415 square feet
let elapsed = (CFAbsoluteTimeGetCurrent() - startTime)

print("[\(elapsed)s | \(elapsed/60)m]")
print("Total quare feet of paper required for Santa is \(totalPaperRequired)! ")
print("Total ribbon length required for Santa is \(totalFeetOfRibbon) ")