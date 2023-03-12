import Foundation

public class PaymentController {
    let services: [Service]
    
    public init(services: [Service]) {
        self.services = services
    }
    
    public func calculateEarnings() -> Float {
        self.services.reduce(0) { Result, NextElement in
            Result + NextElement.income
        }
    }
}


