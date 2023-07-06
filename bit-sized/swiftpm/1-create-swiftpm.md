# Create Own Swift Package Manager

## Create an initial package

On Xcode Menu: `File > New > Package`, name it as you please. 

The package project should look similar to this:

```
SwiftPackageDemo
├── Package.swift
├── README.md
├── Sources
│   └── SwiftPackageDemo
│       └── SwiftPackageDemo.swift
└── Tests
    └── SwiftPackageDemoTests
        └── SwiftPackageDemoTests.swift
```

## Setup package

The package can be setup on the `Package.swift` file. You can leave everything in default and go to next step.

### Dependency setup

However, if your code needs 3rd party libraries to work, you need to add it on the `dependencies` parameter. For example, you need to a yaml decoder, `Yams`, you need to add it like so:

```swift
dependencies: [ .package(url: "https://github.com/jpsim/Yams.git", from: "5.0.6") ]
```

### Resource setup

If your code have other files like .json, .yml, .txt, .jpg, .etc, you also need to declare it. Create a `Resources` folder inside the `Sources` folder. The name does not matter, as long as it is the same on your setup. Then, add `resources: [Resources]?` parameter on the `.testTarget()` parameter like so:

```swift
    targets: [
        .target(
            name: "MyPackage",
            dependencies: ["Yams"]
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "MyPackageTests",
            dependencies: ["MyPackage"],
        ),
    ]
```

The `package.swift` will look like this:

```swift
// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DeksHelper",
    products: [ visible to other packages.
        .library(
            name: "DeksHelper",
            targets: ["DeksHelper"]),
    ],
    dependencies: [
        .package(url: "https://github.com/jpsim/Yams.git", from: "5.0.6")
    ],
    targets: [
        .target(
            name: "DeksHelper",
            dependencies: ["Yams"],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "DeksHelperTests",
            dependencies: ["DeksHelper"],
            resources: [.process("Resources")]
        ),
    ]
)

```

Note that  to access the resource files you need to use `Bundle.module` instead of `Bundle.main`

The setup is the same with test target if you put some resource files for test use.

## Put your code, Build, and Test

Put your code inside `Sources/<PackageName>/`. Set the appropriate access controls. 

Build the package to see if it will compile.

Test your code if it functions as expected.

## Publish

Commit and push your code on your github.

## Access

To add your package to a new or existing project, 

1. On Xcode menu, `File > Add Packages...`
2. On the search bar, paste in the github link of the repository (e.g. https://github.com/dekstur27/MyPackage.git)
3. Import on the file you need it to (e.g. import MyPackage)

## Done!

Try it.

## References
https://developer.apple.com/documentation/xcode/creating-a-standalone-swift-package-with-xcode
