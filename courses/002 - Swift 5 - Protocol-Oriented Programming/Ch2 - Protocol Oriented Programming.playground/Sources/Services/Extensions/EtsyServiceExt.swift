import Foundation

extension EtsyService: Service {
    public func itemSold(price: Float) {
        itemSold(profit: price)
    }
    
    public var income: Float {
        return earnings
    }
    
}
