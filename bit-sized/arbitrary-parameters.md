# How to make functions with arbitrary parameters

## Swift

```swift
func functionWithArbitraryParameters(args: String...) {
    print(args)
}

functionWithArbitraryParameters(args: "one", "two", "three")
// ["one", "two", "three"]
```

## Objective-C

```objc
- (void)methodWithArbitraryParameters:(int)count, ... {
    
    va_list args;
    va_start(args, count);
    
    for (int i = 0; i < count; i++) {
        NSString *names = va_arg(args, NSString *);
        NSLog(@"%@", names);
    }
    
    va_end(args);
}
```

# C

```c
#ifndef DEBUG
BOOL isDebug = NO;
#else
BOOL isDebug = YES;
#endif

#define NSLog(format, ...) {\
\
    if (isDebug) {\
        NSArray<NSString *> *stringArray = @[__VA_ARGS__];\
        NSLog(format, __VA_ARGS__);\
    }\
\
}
```