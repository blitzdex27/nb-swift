# How to add script to every page the WKWebView opens

```swift

let config = WKWebViewConfiguration()
let script = WKUserScript(source: "document.body.style.backgroundColor = 'green'", injectionTime: .atDocumentEnd, forMainFrameOnly: true)
config.userContentController.addUserScript(script)
let webView = WKWebView(frame: .zero, configuration: config)

```