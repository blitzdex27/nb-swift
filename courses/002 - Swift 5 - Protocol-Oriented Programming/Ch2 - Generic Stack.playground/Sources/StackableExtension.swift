import Foundation

public extension Stackable {
    
    var count: Int {
        return data.count
    }
    var isEmpty: Bool {
        return count == 0
    }
    
    mutating func push(item: StackElement) -> Void {
        data.append(item)
    }
    mutating func pop() -> StackElement? {
        guard isEmpty != true else {
            return nil
        }
        return data.popLast()
    }
    func peak() -> StackElement? {
        guard isEmpty != true else {
            return nil
        }
        return data.last
    }

    
}
