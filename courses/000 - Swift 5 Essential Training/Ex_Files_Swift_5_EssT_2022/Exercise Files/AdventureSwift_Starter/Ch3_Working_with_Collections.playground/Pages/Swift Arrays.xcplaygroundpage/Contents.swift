/*:
 # Swift Arrays
 ---
 
 ## Topic Essentials
 Swift arrays are **ordered lists**, meaning that the position of each element is determined by the order it was added. Arrays work off of indexes, which can be used to access and modify the values of individual items.
 
 ### Objectives
 + Create arrays with different syntax
 + Add initial values
 + Use the `count` and `isEmpty` methods
 + Access and update array values using subscripts
 
 [Next Topic](@next)
 
 */
// Creating arrays
var names: [String] = [] // empty array
var names2: Array<String> = Array<String>() // empty array using longer syntax
var names3: [[String]] = [["Dekstur", "Terroy", "IamDexter", "Warheit"]] // array of array of strings
var names4: Array<Array<String>> = Array<Array<String>>() // equivalent syntax from the previous line

// Count and isEmpty
names.count
names.isEmpty

// Accessing array values
names3[0]
