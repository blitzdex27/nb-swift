# Apple Push Notification

## Setup

### Apple developer account setup
- On your developer account, create an explicit identifier and include the Push Notification service, then create a profile from it
- On your app `Signing and Capabilities`, apply the newly created identifier and profile
- Add `Push notification` capability
- Add `Background modes` capability
- On your developer account in `Certificates, Identifiers, and Profiles` page, go to `Keys` section, then create a private key for Push Notification. Save it and upload to safe storage because you can only download it once
- You can use the downloaded file to 3rd party cloud messaging services like Firebase Cloud Messaging

### Codebase setup
- On `AppDelegate.swift` import the `UserNotification`
- Implement the `UNUserNotificationCenterDelegate`
- Handle notifications from `UNUserNotificationCenterDelegate` delegate methods
- For more details about handling notification, continue to the next section.

#### If using Firebase for push notification
Codebase setup
- Install `FirebaseMessaging` dependency (via pod, swift package manager, framework, etc)
- On `AppDelegate.swift` import the `FirebaseCore` and `FirebaseMessaging`
- On `application(_:didFinishLaunchingWithOptions:)` delegate configure firebase and messaging delegate
  ```swift
  FirebaseApp.configure()
  Messaging.messaging().delegate = self
  ```

## Handling Routes for different app states (foreground, background, and terminated state)
- You can handle the notification using various delegate methods.
- You can handle it directly without user tapping on it while in foreground.
- You can handle notification taps from foreground, background, and even in terminated state.

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
```swift
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }

        if let response = connectionOptions.notificationResponse {
            let notification = response.notification
            // Handle notification here
        }
    }
```
Note: This delegate method upon returning, will call the `userNotificationCenter(_:didReceive:withCompletionHandler:)` delegate method.

