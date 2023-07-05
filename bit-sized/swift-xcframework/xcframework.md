# Swift XCFramework

TLDR:
1. Create Framework project
2. Put your code
3. Build archives
4. Build framework

## Create framework project

On XCode menu, go to `File > New > Project > Framework & Library > Framework`.

## Put your code

Code as you normally do. Test as you normally do. No need edit the single self-generated `FrameworkProjectName.h` file on project creation.

## Build archives

Create archives for each platform you want to support (e.g. iOS, iOS Simulator, macOS, Mac Catalyst)

```bash
xcodebuild archive 
    -project FrameworkDemo.xcodeproj
    -scheme FrameworkDemo
    -destination "generic/platform=iOS"
    -archivePath "archives/FrameworkDemo-iOS"
    SKIP_INSTALL=NO 
    BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
```

To support iOS Simulator and others, change the `destination` value based on platform:

| Value | Platform |
|---|---|
| generic/platform=iOS | iOS |
| generic/platform=iOS Simulator | iOS Simulator |
| generic/platform=macOS | macOS |
| generic/platform=macOS,variant=Mac Catalyst | Mac Catalyst |

Note: Do not forget to change the `arhivePath` for each platform you support.

## Build framework


