# Scripting: Hybrid Objective-C and Swift

```bash
swiftc -import-objc-header testswift-Bridging-Header.h Hello.m main.swift -o MyApp
```

Note: Only Objective C classes will be visible to Swift, not the other way around.

Alternatively, you can create a console app in xcode and do your scripting works there
