import Foundation

extension AmazonService: Service {
    public func itemSold(price: Float) {
        orderPlaced(payment: price)
    }
    
    public var income: Float {
        return balance
    }
    
}
