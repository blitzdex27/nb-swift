/*:
 # Core Array Methods
 ---
 
 ## Topic Essentials
 Now that we know how to create and access arrays, we need to learn how to dynamically modify them. Like `Strings`, `Arrays` come with several handy methods built right in for just that purpose.
 
 ### Objectives
 + Create an array called **characterClasses** and assign it initial values
 + Use `append` and += operator to add items
 + Use the `insert` and `remove` methods to change the array further
 + Explore the `reverse`, `contains`, and`sort` methods
 + Create a jagged array called **skillTree** that stores arrays as its values
 + Use chained **subscript syntax** to access a value in **skillTree**
 
  [Previous Topic](@previous)                                                 [Next Topic](@next)
 
 */
// Changing & appending items
var names: [String] = ["Dekstur", "Dexter", "IamDexter"]
names[0] = "dekstur"
names.append("Terroy")
names += ["Warheit", "Nabei"]

//Inserting and removing items
names.insert("Han li", at: 1)
names.insert(contentsOf: ["Linley", "Wang Lin"], at: 3)
names.remove(at: 4)


// Ordering and querying values
//names.sort()
//names.reverse()

var sortedNames: [String] = names.sorted()
var reverseSortedNames: [String] = names.reversed()

names.contains("Dexter")

// 2D arrays and subscripts
var twoDArray: [[String]] = [names]
twoDArray[0][0]
