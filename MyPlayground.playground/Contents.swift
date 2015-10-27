//: Playground - noun: a place where people can play

import UIKit

var originalString = "11:22 - 1:30"
var dashIndex = originalString.lowercaseString.characters.indexOf("-")
var dashIndexString = "\(dashIndex!)"
var DashIndexInt = Int(dashIndexString)!


//left of dash
let leftOfDashRange = originalString.startIndex.advancedBy(0)..<originalString.startIndex.advancedBy(DashIndexInt-1)
//let leftOfDashRange = advance(originalString.startIndex, 0)..<advance(originalString.startIndex, DashIndexInt-1)
var leftOfDashString = originalString[leftOfDashRange]
print(leftOfDashString)


let colonIndex = leftOfDashString.lowercaseString.characters.indexOf(":")
let colonIndexString = "\(colonIndex!)"
let colonIndexInt = Int(colonIndexString)!

//left of colon
let leftOfColonRange = leftOfDashString.startIndex.advancedBy(0)..<leftOfDashString.startIndex.advancedBy(colonIndexInt)
//let leftOfColonRange = advance(leftOfDashString.startIndex, 0)..<advance(leftOfDashString.startIndex, colonIndexInt)
let leftOfColonString = leftOfDashString[leftOfColonRange]
let leftOfColonInt = Int(leftOfColonString)!
print(leftOfColonInt)

//right of colon
let rightOfColonRange = leftOfDashString.startIndex.advancedBy(colonIndexInt+1)..<leftOfDashString.endIndex.advancedBy(0)
//let rightOfColonRange = advance(leftOfDashString.startIndex, colonIndexInt+1)..<advance(leftOfDashString.endIndex, 0)
let rightOfColonString = leftOfDashString[rightOfColonRange]
let rightOfColonInt = Int(rightOfColonString)!
print(rightOfColonInt)

//------------------------------------------

//right of dash
let rightOfDashRange = originalString.startIndex.advancedBy(DashIndexInt+2)..<originalString.endIndex.advancedBy(0)
//let rightOfDashRange = advance(originalString.startIndex, DashIndexInt+2)..<advance(originalString.endIndex, 0)
var rightOfDashString = originalString[rightOfDashRange]
print(rightOfDashString)
let colonIndex2 = rightOfDashString.lowercaseString.characters.indexOf(":")
let colonIndexString2 = "\(colonIndex2!)"
let colonIndexInt2 = Int(colonIndexString2)!

//left of colon
let leftOfColonRange2 = rightOfDashString.startIndex.advancedBy(0)..<rightOfDashString.startIndex.advancedBy(colonIndexInt2)
//let leftOfColonRange2 = advance(rightOfDashString.startIndex, 0)..<advance(rightOfDashString.startIndex, colonIndexInt2)
let leftOfColonString2 = rightOfDashString[leftOfColonRange2]
let leftOfColonInt2 = Int(leftOfColonString2)!
print(leftOfColonInt2)

//right of colon
let rightOfColonRange2 = rightOfDashString.startIndex.advancedBy(colonIndexInt2+1)..<rightOfDashString.endIndex.advancedBy(0)
//let rightOfColonRange2 = advance(rightOfDashString.startIndex, colonIndexInt2+1)..<advance(rightOfDashString.endIndex, 0)
let rightOfColonString2 = rightOfDashString[rightOfColonRange2]
let rightOfColonInt2 = Int(rightOfColonString2)!
print(rightOfColonInt2)
