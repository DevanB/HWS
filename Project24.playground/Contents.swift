import UIKit

extension Int {
    mutating func plusOne() {
        self += 1
    }
}

var myInt = 10
myInt.plusOne()

var otherInt = 10
otherInt.plusOne()

extension Integer {
    func squared() -> Self {
        return self * self
    }
}

let i: Int = 0
print(i.squared())

let j: UInt64 = 8
print(j.squared())

var string = "Hello    "
string = string.trimmingCharacters(in: .whitespacesAndNewlines)

extension String {
    mutating func trimmed() {
        self = trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

var otherString = "Goodbye    "
otherString.trimmed()