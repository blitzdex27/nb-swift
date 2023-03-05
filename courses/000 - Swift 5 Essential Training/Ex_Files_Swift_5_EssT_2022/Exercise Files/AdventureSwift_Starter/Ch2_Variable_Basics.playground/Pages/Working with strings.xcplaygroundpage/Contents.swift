/*:
 # Working with Strings
 ---
 
 ## Topic Essentials
 There are several `String` methods that you'll be using on a regular basis, which include `contains`, `append`, `insert`, `remove`, and `split`. Refer to the documentation to see everything the `String` class offers.
 
 ### Objectives
 + Retrieve state information about a string using `count` and `isEmpty`
 + Use each of the mentioned class methods to alter the starting string
 
  [Previous Topic](@previous)                                                 [Next Topic](@next)
 
 */
// Test variable
var message: String = "Hello friend, how are you? Are you going home?"

// String data
message.count
message.isEmpty
message.contains("Hello")

// Append and Insert
message.append("Now?")

// Remove and Split
message.removeFirst()
message.removeLast()
//message.removeAll()

message.split(separator: ",")

print(message)
