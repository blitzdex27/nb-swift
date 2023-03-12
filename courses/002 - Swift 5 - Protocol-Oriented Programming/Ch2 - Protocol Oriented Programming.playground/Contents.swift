import Foundation

/* Swift 5: Protocol oriented programming */
/* Chapter 2 challenge - Remove tight coupling */
/* repeat times: 1 */
/* coded using Macincloud service */

let amazonService = make(service: .amazon)
let etsyService = make(service: .etsy)

let controller = PaymentController(services: [amazonService, etsyService])

amazonService.itemSold(price: 100)
etsyService.itemSold(price: 25)
amazonService.itemSold(price: 12.5ß0)
ß
print("Total earned: \(controller.calculateEarnings())")
