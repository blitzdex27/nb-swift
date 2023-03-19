/* Swift 5: Protocol oriented programming */
/* Chapter3 challenge - Generic Stack */
/* repeat times: 1 */
/* coded using Macincloud service */

import Foundation

struct Names: Stackable {
    
    var data: [String]
    
    var count: Int
    
    var isEmpty: Bool
    init(data: [String]) {
        self.data = data
        self.count = data.count
        self.isEmpty = data.count == 0
    }

}

var names: Names = Names(data: ["deks"])
names.push(item: "deki")
print("Push: \(names.peak() ?? "")")

var removedName: String = names.pop() ?? ""

print("Removed: \(removedName)")

print("Peak: \(names.peak() ?? "")")

print("Count: \(names.count)")
