import Foundation

public protocol Stackable {
    associatedtype StackElement
    var data: [StackElement] { get set }
    
    var count: Int { get }
    var isEmpty: Bool { get }
    
    mutating func push(item: StackElement) -> Void
    mutating func pop() -> StackElement?
    func peak() -> StackElement?
    
    init(data: [StackElement])
  
}
