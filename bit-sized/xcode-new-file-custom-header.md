# Xcode new file custom header

1. Create file `IDETemplateMacros.plist` on: `<WorkspaceName>.xcworkspace/xcuserdata/[username].xcuserdatad`

2. Open the file and add `FILEHEADER` property on the root
3. Add your custom header on the value field of `FILEHEADER`

To know about macros you can use here, see [Text macro reference](https://help.apple.com/xcode/mac/9.0/index.html?localePath=en.lproj#/dev7fe737ce0)

For more information, check out this [blog](https://oleb.net/blog/2017/07/xcode-9-text-macros)

## References

- https://oleb.net/blog/2017/07/xcode-9-text-macros/
- https://help.apple.com/xcode/mac/9.0/index.html?localePath=en.lproj#/dev7fe737ce0