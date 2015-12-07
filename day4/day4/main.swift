//
//  main.swift
//  day4
//
//  Created by David McGraw on 12/6/15.
//

import Foundation

extension String  {
    var md5: String! {
        let cStr = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(cStr!, CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)), result);
        return String(format: "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15])
    }
}

let startTime = CFAbsoluteTimeGetCurrent()

var value = 0
var input = ""
var hash = ""
repeat {
    input = "iwrupvqb\(String(value))"
    hash = input.md5
    value++
} while !hash.hasPrefix("00000")


let elapsed = (CFAbsoluteTimeGetCurrent() - startTime)

print("[\(elapsed)s | \(elapsed/60)m] \(input), \(hash)")

// 5 zeros
// [5.89812499284744s | 0.0983020832141241m] iwrupvqb346386, 0000045c5e2b3911eb937d9d8c574f09

// 6 zeros
// [169.532705008984s | 2.82554508348306m] iwrupvqb9958218, 00000094434e1914548b3a1af245fb27