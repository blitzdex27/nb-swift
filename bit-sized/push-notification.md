# Apple Push Notification


## Handling Routes for different app states (foreground, background, and terminated state)

### Summary

- `userNotificationCenter(_:didReceive:withCompletionHandler:)`:
    - Use this if you want to handle user tapping on the notification
    - Trigger: on user tap; States: foreground, background, terminated
- `userNotificationCenter(_:willPresent:withCompletionHandler:)`:
    - Use this if you want to handle notification as soon as notification was received while app is in foreground.
    - You can use the completion handler to determine how you want it to be presented.
    - Trigger: upon receiving notification; States: foreground
- `scene(_:willConnectTo:options:)`
    - When user taps on notification, this method will have the notification info and you can handle it here
    - This method will be called first before the `userNotificationCenter(_:didReceive:withCompletionHandler:)`
    - Use this if have some configurations to do based on the notification received
    - Trigger: upon opening the app; States: foreground
    - The connectionOptions parameter will have notificationResponse value containing the notification when the method of opening the app is through tapping on notification 


### All States

For all app states, you can use `userNotificationCenter(_:didReceive:withCompletionHandler:)`.
This will only be triggered when user tap on notification.
```swift
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let notification = response.notification
        switch UIApplication.shared.applicationState {
        case .active:
            // Handle notification
            break
        case .inactive:
            // Handle notification
            break
        case .background:
            // Handle notification
            break
        default:
            fatalError()
        }
    }
```

Note: For foreground state, the completion should be called on `userNotificationCenter(_:willPresent:withCompletionHandler:)` delegate method before the `userNotificationCenter(_:didReceive:withCompletionHandler:)` will be called. 

### Foreground State

Will trigger immediately upon receiving notification.
```swift
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        // Handle notification
        completionHandler(.banner)
    }
```

Note: This delegate method upon calling completionHandler, will call the `userNotificationCenter(_:didReceive:withCompletionHandler:)` delegate method.



### Terminated State

On `SceneDelegate.swift`, from the delegate method `scene(_:willConnectTo:options:)`, check if `connectionOptions.notificationResponse` has value:
```
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }

        if let response = connectionOptions.notificationResponse {
            let notification = response.notification
            // Handle notification here
        }
    }
```
Note: This delegate method upon returning, will call the `userNotificationCenter(_:didReceive:withCompletionHandler:)` delegate method.

