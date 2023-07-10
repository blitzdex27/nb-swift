# How to deprecate in Swift

```swift
@available(*, deprecated, message: "Use sayHello(name:) instead")
func sayHello() {
    print("Hello.")
}

func sayHello(name: String) {
    print("Hello \(name).")
}
```
