# Swift XCFramework

TLDR;
1. Create Framework project
2. Put your code
3. Build archives
4. Build framework

## Create framework project

On XCode menu, go to `File > New > Project > Framework & Library > Framework`.

On your `Project > Build Settings (All) > Build Options`, set the `BUILD_LIBRARIES_FOR_DISTRIBUTION` or *Build Libraries for Distribution* to YES.

## Put your code

Code as you normally do. Test as you normally do. No need to edit the single self-generated `FrameworkProjectName.h` file on project creation.

## Build archives

Create archives for each platform you want to support (e.g. iOS, iOS Simulator, macOS, Mac Catalyst)

The following code will create an archive for iOS Simulator platform.

```bash
xcodebuild archive 
    -project FrameworkDemo.xcodeproj
    -scheme FrameworkDemo
    -destination "generic/platform=iOS Simulator"
    -archivePath "archives/FrameworkDemo-iOS_Simulator"
    SKIP_INSTALL=NO 
    BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
```

To support iOS Simulator and others, create a separate archive. Change the `destination` value based on platform:

| Value | Platform |
|---|---|
| generic/platform=iOS | iOS |
| generic/platform=iOS Simulator | iOS Simulator |
| generic/platform=macOS | macOS |
| generic/platform=macOS,variant=Mac Catalyst | Mac Catalyst |

Note: Do not forget to change the `arhivePath` for each platform you support (e.g. `"archives/FrameworkDemo-iOS_Simulator"`).

## Build framework

Build framework that you can use on your other projects.

The following code will use the framework inside the *archives/FrameworkDemo-iOS_Simulator.xcarchive* to create the framework that supports a single platform, which is *iOS Simulator*.

```bash
xcodebuild 
    -create-xcframework 
    -archive archives/FrameworkDemo-iOS_Simulator.xcarchive 
    -framework FrameworkDemo.framework 
    -output xcframeworks/FrameworkDemo.xcframework
```

Done. Go to *xcframeworks* folder and you will see your framework. To use it on other projects, go to `General > Frameworks, Libraries, and Embedded Content` then drag and drop the *FrameworkDemo.xcframework* file.

## Samples

### Supports iOS and iOS Simulator variant 1 (Recommended)

```bash
xcodebuild archive 
    -project FrameworkDemo.xcodeproj
    -scheme FrameworkDemo
    -destination "generic/platform=iOS"
    -archivePath "archives/FrameworkDemo-iOS"
    SKIP_INSTALL=NO 
    BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
```

```bash
xcodebuild archive 
    -project FrameworkDemo.xcodeproj
    -scheme FrameworkDemo
    -destination "generic/platform=iOS Simulator"
    -archivePath "archives/FrameworkDemo-iOS_Simulator"
    SKIP_INSTALL=NO 
    BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
```

```bash
xcodebuild 
    -create-xcframework 
    -archive archives/FrameworkDemo-iOS.xcarchive 
    -framework FrameworkDemo.framework 
    -archive archives/FrameworkDemo-iOS_Simulator.xcarchive 
    -framework FrameworkDemo.framework 
    -output xcframeworks/FrameworkDemo.xcframework
```

### Supports iOS and iOS Simulator variant 2

```bash
xcodebuild archive 
    -scheme FrameworkDemo 
    -configuration Release 
    -destination 'generic/platform=iOS' 
    -archivePath './build/FrameworkDemo.framework-iphoneos.xcarchive' 
    SKIP_INSTALL=NO 
    BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
```

```bash
xcodebuild archive 
    -scheme FrameworkDemo 
    -configuration Release 
    -destination 'generic/platform=iOS Simulator' 
    -archivePath './build/FrameworkDemo.framework-iphonesimulator.xcarchive' 
    SKIP_INSTALL=NO 
    BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
```

```bash
xcodebuild 
    -create-xcframework 
    -framework './build/FrameworkDemo.framework-iphoneos.xcarchive/Products/Library/Frameworks/FrameworkDemo.framework' 
    -framework './build/FrameworkDemo.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/FrameworkDemo.framework' 
    -output './build/FrameworkDemo.xcframework'
```

## References

- https://developer.apple.com/documentation/xcode/creating-a-multi-platform-binary-framework-bundle
- https://www.kodeco.com/17753301-creating-a-framework-for-ios#toc-anchor-005
