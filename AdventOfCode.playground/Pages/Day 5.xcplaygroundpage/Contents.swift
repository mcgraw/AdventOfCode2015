/*:

[http://adventofcode.com/day/5](http://adventofcode.com/day/5)

###--- Day 5: Doesn't He Have Intern-Elves For This? ---

Santa needs help figuring out which strings in his text file are naughty or nice.

A nice string is one with all of the following properties:

It contains at least three vowels (aeiou only), like aei, xazegov, or aeiouaeiouaeiou.
It contains at least one letter that appears twice in a row, like xx, abcdde (dd), or aabbccdd (aa, bb, cc, or dd).
It does not contain the strings ab, cd, pq, or xy, even if they are part of one of the other requirements.
For example:

- ugknbfddgicrmopn is nice because it has at least three vowels (u...i...o...), a double letter (...dd...), and none of the disallowed substrings.
- aaa is nice because it has at least three vowels and a double letter, even though the letters used by different rules overlap.
- jchzalrnumimnmhp is naughty because it has no double letter.
- haegwjzuvuyypxyu is naughty because it contains the string xy.
- dvszwmarrgswjxmb is naughty because it contains only one vowel.
How many strings are nice?

Your puzzle answer was 258.

###--- Part Two ---

Realizing the error of his ways, Santa has switched to a better model of determining whether a string is naughty or nice. None of the old rules apply, as they are all clearly ridiculous.

Now, a nice string is one with all of the following properties:

It contains a pair of any two letters that appears at least twice in the string without overlapping, like xyxy (xy) or aabcdefgaa (aa), but not like aaa (aa, but it overlaps).
It contains at least one letter which repeats with exactly one letter between them, like xyx, abcdefeghi (efe), or even aaa.
For example:

- qjhvhtzxzqqjkmpb is nice because is has a pair that appears twice (qj) and a letter that repeats with exactly one letter between them (zxz).
- xxyxx is nice because it has a pair that appears twice and a letter that repeats with one between, even though the letters used by each rule overlap.
- uurcxstgmygtbstg is naughty because it has a pair (tg) but no repeat with a single letter between them.
- ieodomkazucvgmuy is naughty because it has a repeating letter with one between (odo), but no pair that appears twice.
How many strings are nice under these new rules?

Your puzzle answer was 53.

[Contents](Contents) | [Go Back To Day 4](Day%204) | [Continue to Day 6](@next)
*/

// Used so we can get access to the timing functions
import CoreFoundation

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
let input = XMFileManager.shared.loadStringInputFromResource("day5")

let startTime = CFAbsoluteTimeGetCurrent()

// Split the input
var strings = input.characters.split { $0 == "\n" }.map(String.init)

// Initialize our nice count
var niceCount = 0

// Iterate through our input
for (pos, string) in strings.enumerate() {
    
    // Part 1
    if string.containsMinimumOfThreeVowels() &&
        string.containsRepeatingLetter() &&
        !string.containsInvalidSequences() {
        niceCount++
    }
    
    // Part 2
//    if string.containsValidRepeatingPairs() {
//        niceCount++
//    }
}

let elapsed = (CFAbsoluteTimeGetCurrent() - startTime)

print("[\(elapsed)s | \(elapsed/60)m] \(niceCount) strings are nice!")

// day5
// p1 - [5.44962400197983s | 0.0908270666996638m] 258 strings are nice!
// p2 - [3.55411899089813s | 0.0592353165149689m] 53 strings are nice!



