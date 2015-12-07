/*:

[http://adventofcode.com/day/3](http://adventofcode.com/day/3)

###--- Day 3: Perfectly Spherical Houses in a Vacuum ---

Santa is delivering presents to an infinite two-dimensional grid of houses.

He begins by delivering a present to the house at his starting location, and then an elf at the North Pole calls him via radio and tells him where to move next. Moves are always exactly one house to the north (^), south (v), east (>), or west (<). After each move, he delivers another present to the house at his new location.

However, the elf back at the north pole has had a little too much eggnog, and so his directions are a little off, and Santa ends up visiting some houses more than once. How many houses receive at least one present?

For example:

- > delivers presents to 2 houses: one at the starting location, and one to the east.
- ^>v< delivers presents to 4 houses in a square, including twice to the house at his starting/ending location.
- ^v^v^v^v^v delivers a bunch of presents to some very lucky children at only 2 houses.
Your puzzle answer was 2081.

###--- Part Two ---

The next year, to speed up the process, Santa creates a robot version of himself, Robo-Santa, to deliver presents with him.

Santa and Robo-Santa start at the same location (delivering two presents to the same starting house), then take turns moving based on instructions from the elf, who is eggnoggedly reading from the same script as the previous year.

This year, how many houses receive at least one present?

For example:

- ^v delivers presents to 3 houses, because Santa goes north, and then Robo-Santa goes south.
- ^>v< now delivers presents to 3 houses, and Santa and Robo-Santa end up back where they started.
- ^v^v^v^v^v now delivers presents to 11 houses, with Santa going one direction and Robo-Santa going the other.
Your puzzle answer was 2341.

[Contents](Contents) | [Go Back To Day 2](Day%202) | [Continue to Day 2](@next)
*/

// Used so we can get access to the timing functions
import CoreFoundation

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
let input = XMFileManager.shared.loadStringInputFromResource("day3")

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

