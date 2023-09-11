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