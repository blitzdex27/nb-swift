# Swift - How to monitor user actions or events

## Method 1 - Subclassing UIApplication

1. Subclass `UIApplication` and override `sendEvent:` method

```swift
class CustomApplication: UIApplication {

    override func sendEvent(_ event: UIEvent) {
        print("Event triggered!: \(event)")
        super.sendEvent(event)
    }
    
}
```

2. Create `main.swift` file

```
import UIKit

UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,

    NSStringFromClass(CustomApplication.self), //was created at step 1
    NSStringFromClass(AppDelegate.self)
)
```

3. Comment out the AppDelegate attribute

```swift
import UIKit

//@main
class AppDelegate: UIResponder, UIApplicationDelegate {

// ... some code

}
```

Done.

## Method 2 - Method Swizzling

```swift
import Foundation
import UIKit

extension UIApplication {
    
    static let swizzleSendEvent: Void = {
        let originalSelecto = #selector(UIApplication.sendEvent(_:))
        let swizzleSelector = #selector(UIApplication.customEvent(_:))
        
        let originalMethod = class_getInstanceMethod(UIApplication.self, originalSelecto)
        let swizzledMethod = class_getInstanceMethod(UIApplication.self, swizzleSelector)
        
        method_exchangeImplementations(originalMethod!, swizzledMethod!)
    }()
    
    @objc func customEvent(_ event: UIEvent) {
        print("event triggered! \(event)")
        customEvent(event)
    }
}
```