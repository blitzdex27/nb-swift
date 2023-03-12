/*:
 # Swift Dictionaries
 ---
 
 ## Topic Essentials
 Like arrays, dictionaries are collection types, but instead of holding single values accessed by indexes, they hold **key-value** pairs. All keys need to be of the same type, and the same goes for values. It's important to know that dictionary items are **unordered**, and their values are accessed with their associated keys.
 
 ### Objectives
 + Understand basic dictionary syntax
 + Create a dictionary called **blacksmithShop** and fill it with a few items
 + Access and udpate key-value pairs using subscript
 + Access all the keys and values of **blacksmithShopItems**
 
 [Previous Topic](@previous)                                                 [Next Topic](@next)

 */
// Creating dictionaries
var prices: Dictionary<String, Int> = [ "Apple": 20, "Orange": 20]
var prices2: [String: Int] = [ "Pencil": 10, "Eraser": 5 ]

// Accessing and modifying values
print(prices["Apple"] ?? 10)
prices["Apple"] = 15 as Int


// All keys and values
print(prices.keys)
var priceKeyes = [String](prices.keys)
print(priceKeyes)

var priceValues = [Int](prices.values)



