# Swift iOS Deeplinking / Handling URL Scheme

## Accept incoming url scheme

1. register scheme your app can handle
   
   - on Target > Info > Url Types, add a new entry
   - define the identifier (e.g com.deks.appname2192)
   - define the url scheme (e.g app1)

2. handle incoming url scheme
   
   - If using scenes
    ```swift
        func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
        if let urlContext = URLContexts.first {
            print(urlContext.url)
            ViewController.color = .blue
        }
    }
    ```
   - if using app delegate
    ```swift
        func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return false
        }
        
        print(components.url ?? "No url")
        print(components.queryItems ?? "No query")
        ViewController.color = .blue
        
        return true
        
    }

    ```

## Initiate url scheme call

1. Setup plist
   ```xml
   <key>LSApplicationQueriesSchemes</key>
	<array>
		<string>app1</string>
	</array>
   ```
   
2. Call
```
        let urlString = "app1://?name=dex"
        guard let url = URL(string: urlString) else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:]) { isWhat in
                print("isWhat = \(isWhat)")
            }
        }
```