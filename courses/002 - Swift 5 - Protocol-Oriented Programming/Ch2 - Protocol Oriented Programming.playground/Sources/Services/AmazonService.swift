import Foundation

class AmazonService {
    var balance: Float = 0
    
    init() {}
    
    func orderPlaced(payment: Float) -> Void {
        balance += payment
    }
    
    var earnings: Float {
        return balance
    }
}
