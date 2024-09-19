# Apple Push Notification

## Setup

Apple developer account setup
- On your developer account, create an explicit identifier and include the Push Notification service, then create a profile from it
- On your app `Signing and Capabilities`, apply the newly created identifier and profile
- Add `Push notification` capability
- Add `Background modes` capability
- On your developer account in `Certificates, Identifiers, and Profiles` page, go to `Keys` section, then create a private key for Push Notification. Save it and upload to safe storage because you can only download it once
- You can use the downloaded file to 3rd party cloud messaging services like Firebase Cloud Messaging

Codebase setup
- On `AppDelegate.swift` import the `UserNotification`
- Implement the `UNUserNotificationCenterDelegate`
- Handle notifications from `UNUserNotificationCenterDelegate` delegate methods
- For more details about handling notification, continue to the next [section](##handling-routes-for-different-app-states-foreground-background-and-terminated-state).

## If using Firebase for push notification
Setup firebase cloud messaging
- On [Firebase console](https://console.firebase.google.com/), create a new project.
- Once created, setup your APN (Apple Push Notification) authentication key
  - Go to project settings and choose 'Cloud Messaging'
  - Under `Apple app configuration`, click upload where it says `APNs Authentication Key`
  - Upload the `APNs authentication key` we downloaded from [Certificates, Identifiers & Profiles - Keys - Apple Developer](https://developer.apple.com/account/resources/authkeys/list)
  - The `Key ID` can be retrieved by opening the key we created, this is also where we downloaded the `APNs authentication key`
  - The `Team ID` is your team's ID or your own developer ID.
  - Click upload
- Once uploaded, tap on 'All Products' and search for 'Cloud Messaging'
- Add an iOS app.
  - Enter your app's bundle id - required
  - App nickname (any name for your reference only) - optional
  - App store id - optional
  - Download `GoogleService-Info.plist`, and put this file on the root of your iOS project
  - Setup firebase cloud messaging in your app (see 'Setup firebase cloud messaging in codebase' below)
  - Once your codebase is setup, you can send test notification
    - Navigate to your project in firebase, and go to `Cloud Messaging`. It should be added in your Project shortcuts.
    - Select 'Create your first campaign'
    - Choose 'Firebase Notification Messages'
    - Enter notification title and body
    - Then select 'Send test message'

Setup firebase cloud messaging in codebase
- Install `FirebaseMessaging` dependency (via pod, swift package manager, framework, etc)
- On `AppDelegate.swift` import the `FirebaseCore` and `FirebaseMessaging`
- On `application(_:didFinishLaunchingWithOptions:)` delegate configure firebase and messaging delegate
  ```swift
  FirebaseApp.configure()
  Messaging.messaging().delegate = self
  ```
- Add implementation for `MessagingDelegate`
  ```swift
  extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let fcmToken {
            /// `fcmToken` is used for sending notification to this device.
            print("xx-->> fcmToken \(fcmToken)")
        }
    }
  }
  ```
Setup receiving remote notification
- On `AppDelegate`, import `UserNotifications`
- Ask user to give authorization for receiving remote notifications
  ```swift
  private func setupPushNotification() {
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, error in
            guard granted else {
                return
            }
            
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
  ```
- Call this anywhere in your app, for now, we will call this in `application(_:didFinishLaunchingWithOptions:)`
  ```swift
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    Messaging.messaging().delegate = self
    setupPushNotification()
    return true
  }
  ```
- Note: When user authorized the remote notifications, the app will receive an fcmToken through `messaging(_:didReceiveRegistrationToken:)` delegate method from `MessagingDelegate`. You can send it to backend or use it yourself. Note that if user reinstalled the app, it will receive the token it was receiving before it was reinstalled which is not valid anymore, but after the accepted the remote notification auth the app will receive new valid fcmToken.

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

