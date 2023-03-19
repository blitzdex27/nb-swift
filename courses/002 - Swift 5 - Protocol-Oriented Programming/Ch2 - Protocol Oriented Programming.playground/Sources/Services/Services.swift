import Foundation

public protocol Service {
    var income: Float { get }
    func itemSold(price: Float) -> Void
}

public enum ServiceType {
    case amazon
    case etsy
}

public func make(service: ServiceType) -> Service {
    switch service {
    case .amazon:
        return AmazonService()
    case .etsy:
        return EtsyService()
    }
    
    
}
