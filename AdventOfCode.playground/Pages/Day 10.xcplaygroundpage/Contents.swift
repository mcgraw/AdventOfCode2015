

// Used so we can get access to the timing functions
import CoreFoundation

var digits = "1113122113"

let startTime = CFAbsoluteTimeGetCurrent()

for _ in 0..<40 {
    var newDigits = ""
    
    var previousDigit: String?
    var numberOfMatchingPreviousDigits = 1
    
    var characterCounter = 0
    for digit in digits.characters {
        let stringDigit = String(digit)
        if stringDigit == previousDigit && characterCounter > 0 {
            numberOfMatchingPreviousDigits += 1
        } else {
            if characterCounter > 0 {
                newDigits += String(numberOfMatchingPreviousDigits) + previousDigit!
            }
            
            previousDigit = stringDigit
            numberOfMatchingPreviousDigits = 1
        }
        
        characterCounter += 1
    }
    
    newDigits += String(numberOfMatchingPreviousDigits) + previousDigit!
    
    digits = newDigits
}

let elapsed = (CFAbsoluteTimeGetCurrent() - startTime)

print("[\(elapsed)s | \(elapsed/60)m] \(digits.characters.count)")