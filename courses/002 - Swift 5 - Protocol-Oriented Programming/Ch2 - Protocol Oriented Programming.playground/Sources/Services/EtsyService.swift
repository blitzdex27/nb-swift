import Foundation

class EtsyService {
    var earnings: Float = 0
    
    init() {}
    
    func itemSold(profit: Float) -> Void {
        earnings += profit
    }
    
    var totalSold: Float {
        return earnings
    }
}
