/*:

[http://adventofcode.com/day/2](http://adventofcode.com/day/2)

### --- Day 2: I Was Told There Would Be No Math ---

The elves are running low on wrapping paper, and so they need to submit an order for more. They have a list of the dimensions (length l, width w, and height h) of each present, and only want to order exactly as much as they need.

Fortunately, every present is a box (a perfect right rectangular prism), which makes calculating the required wrapping paper for each gift a little easier: find the surface area of the box, which is 2*l*w + 2*w*h + 2*h*l. The elves also need a little extra paper for each present: the area of the smallest side.

For example:

- A present with dimensions 2x3x4 requires 2*6 + 2*12 + 2*8 = 52 square feet of wrapping paper plus 6 square feet of slack, for a total of 58 square feet.
- A present with dimensions 1x1x10 requires 2*1 + 2*10 + 2*10 = 42 square feet of wrapping paper plus 1 square foot of slack, for a total of 43 square feet.

All numbers in the elves' list are in feet. How many total square feet of wrapping paper should they order?

### --- Part Two ---

The elves are also running low on ribbon. Ribbon is all the same width, so they only have to worry about the length they need to order, which they would again like to be exact.

The ribbon required to wrap a present is the shortest distance around its sides, or the smallest perimeter of any one face. Each present also requires a bow made out of ribbon as well; the feet of ribbon required for the perfect bow is equal to the cubic feet of volume of the present. Don't ask how they tie the bow, though; they'll never tell.

For example:

- A present with dimensions 2x3x4 requires 2+2+3+3 = 10 feet of ribbon to wrap the present plus 2*3*4 = 24 feet of ribbon for the bow, for a total of 34 feet.
- A present with dimensions 1x1x10 requires 1+1+1+1 = 4 feet of ribbon to wrap the present plus 1*1*10 = 10 feet of ribbon for the bow, for a total of 14 feet.

How many total feet of ribbon should they order?

[Contents](Contents) | [Go Back To Day 1](Day%201) | [Continue to Day 2](@next)
*/
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
let input = XMFileManager.shared.loadStringInputFromResource("day2")

// Let's first break up the input into each present dimension
var dimensions = input.characters.split { $0 == "\n" }.map(String.init)

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
// day2-quick.txt == 101 square feet
print("Total quare feet of paper required for Santa is \(totalPaperRequired)! ")
print("Total ribbon length required for Santa is \(totalFeetOfRibbon) ")

