//
//  Advent of Code : Day 7
//
//  http://adventofcode.com/day/7

import Foundation

public extension String {
    
    var length: Int {
        return self.characters.count
    }
    
    subscript(i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (r: Range<Int>) -> String {
        get {
            return self[Range(start: startIndex.advancedBy(r.startIndex),
                end: startIndex.advancedBy(r.endIndex - r.startIndex))]
        }
    }
}

enum XMOperator: String {
    case AND      = "AND"
    case OR       = "OR"
    case LSHIFT   = "LSHIFT"
    case RSHIFT   = "RSHIFT"
    case NOT      = "NOT"
}

struct XMInstruction {
    
    var operand: XMOperator!
    
    var gate: String!
    var output: String = ""
    
    var lhv: String = "" {
        didSet { compute() }
    }
    var rhv: String = "" {
        didSet { compute() }
    }
    
    init(gate: String, output: String) {
        self.output = output
        self.gate = gate
    }
    
    init(gate: String, value: UInt16) {
        output = String(value)
        self.gate = gate
    }
    
    init(gate: String, rhv: String) {
        lhv = "-1" // NOT will not have a LHV, initialize it to zero so compute can happen
        
        self.rhv = rhv
        self.gate = gate
        self.operand = .NOT
    }
    
    init(gate: String, lhv: String, operand: XMOperator, rhv: String) {
        self.gate = gate
        self.lhv = lhv
        self.rhv = rhv
        self.operand = operand
    }
    
    func hasOutput() -> Bool {
        if let _ = UInt16(output) where output != "0" {
            return true
        }
        return false
    }
    
    mutating func compute() {
        if let op = operand, l = UInt16(lhv), r = UInt16(rhv) {
            switch op {
            case .AND:
                output = String(l & r)
                break
            case .OR:
                output = String(l | r)
                break
            case .LSHIFT:
                output = String(l << r)
                break
            case .RSHIFT:
                output = String(l >> r)
                break
            case .NOT:
                output = String(~r)
                break
            }
        }
        
        if operand == .NOT {
            if let r = UInt16(rhv) {
                output = String(~r)
            }
        }
    }
}

// Helper function to build the required range for the regex element
func buildRangeFromLine(input: String, range: NSRange) -> Range<String.CharacterView.Index> {
    if range.location == NSNotFound {
        return input.endIndex..<input.endIndex
    }
    return Range(start: input.startIndex.advancedBy(range.location), end: input.startIndex.advancedBy(range.location + range.length))
}

// The regex we'll use to pull each part of the instruction
var regex = try! NSRegularExpression(pattern: "([a-z0-9]+)? ?([A-Z]+)? ?([a-z0-9]*) -> (.+)", options: .CaseInsensitive)

// Load in the puzzle input (switch to day5-quick to use a smaller set)
let input = try! String(contentsOfFile: Process.arguments[1], encoding: NSUTF8StringEncoding)

let instructions = input.componentsSeparatedByString("\n")

let startTime = CFAbsoluteTimeGetCurrent()

var gates = [String: XMInstruction]()

var solveFor = ""

// Loop once to build all of the gates and logic structures
for instruction in instructions {
    
    // Break up the given instruction into the necessary components
    let matches = regex.matchesInString(instruction, options: [], range: NSMakeRange(0, instruction.length))[0]
    
    let v1 = instruction[buildRangeFromLine(instruction, range: matches.rangeAtIndex(1))]
    let v2 = instruction[buildRangeFromLine(instruction, range: matches.rangeAtIndex(2))]
    let v3 = instruction[buildRangeFromLine(instruction, range: matches.rangeAtIndex(3))]
    
    let gate = instruction[buildRangeFromLine(instruction, range: matches.rangeAtIndex(4))]
    
    var instruction: XMInstruction!
    if let operand = XMOperator(rawValue: v2) {
        instruction = XMInstruction(gate: gate, lhv: v1, operand: operand, rhv: v3)
    } else {
        if let value = UInt16(v1) {
            instruction = XMInstruction(gate: gate, value: value)
        } else if v2 == "" && v3 == "" {
            instruction = XMInstruction(gate: gate, output: v1)
        } else {
            instruction = XMInstruction(gate: gate, rhv: v2)
        }
    }
    
    // Store the instruction
    if instruction != nil {
        gates[gate] = instruction
    }
}


func updateGateWithValue(atGate: String, value: String) {
    for (gate, var instruction) in gates {
        if !instruction.hasOutput() {
            
            if instruction.lhv == atGate {
                instruction.lhv = value
            }
            
            if instruction.rhv == atGate {
                instruction.rhv = value
            }
            
            gates[gate] = instruction
        }
    }
}

func setValueAtGate(atGate: String, var input: XMInstruction) {
    
    for (gate, instruction) in gates {
        
        if gate == input.output && instruction.hasOutput() {
            input.output = instruction.output
            gates[atGate] = input
            return
        }
        
    }
}

var done = false
repeat {
    
    // Cycle through our gates, looking for finished instructions
    for (gate, instruction) in gates {
        if let value = UInt(instruction.output) {
            updateGateWithValue(gate, value: String(value))
        }
        else if instruction.output != "" {
            setValueAtGate(gate, input: instruction)
        }
        
    }
    
    if let status = gates["a"]?.hasOutput() where status == true {
        done = true
    }
    
} while !done


let elapsed = (CFAbsoluteTimeGetCurrent() - startTime)

print("[\(elapsed)s | \(elapsed/60)m] The value of GATE A \(gates["a"]!.output)")

print(gates["a"])
print(gates["b"])


// Part 1: [86.4715449810028s | 1.44119241635005m] The value of GATE A 956
// Part 2: [84.7617329955101s | 1.41269554992517m] The value of GATE A 40149
