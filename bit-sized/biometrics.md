# iOS Face ID Biometrics

1. Define on Info.plist the `NSFaceIDUsageDescription` (e.g. "The app needs permission to access your Face ID")
2. Import `LocalAuthentication` on the file that will use Face ID.
3. Code:
    ```swift
    @IBAction func authenticateButtonDidTap(_ sender: UIButton) {
        let context = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Need your biometrics to continue!") { isCorrect, error in
                if isCorrect {
                    print("correct")
                } else {
                    print("incorrect")
                }
            }
        } else {
            print("not able to access biometrics")
        }
    }
    ```
