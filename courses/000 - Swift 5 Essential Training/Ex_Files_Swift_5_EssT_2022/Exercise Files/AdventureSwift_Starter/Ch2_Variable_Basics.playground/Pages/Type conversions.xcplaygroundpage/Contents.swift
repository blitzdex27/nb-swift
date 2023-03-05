/*:
 # Type Conversions
 ---
 
 ## Topic Essentials
 Numeric values can be converted to other types using Int, Double, or Float class properties or with explicit syntax. Be aware that in some cases you will need to specify the result type if you want something specific. In other words, the compiler is very smart and will deliver the correct result type, but that might not be the type you want.
 
 ### Objectives
 + Understand explicit conversion and its syntax
 + Convert a Double to an Int and String respectively
 + Concatenate string literals and explicitly casted variables
 
 [Previous Topic](@previous)                                                 [Next Topic](@next)
 
*/
// Test variables
var numInt: Int = 20
var numFloat: Float = 10.2
var numDouble: Double = 30.6

// Explicit conversions
var convertedNumInt: Float = Float(numInt)
var convertedNumFloat: Int = Int(Double(numFloat) + numDouble)
var convertedNumDouble: Float = Float(numDouble)

print(convertedNumDouble)

// Inferred conversion with operators

