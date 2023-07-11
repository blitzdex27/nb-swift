# How to make a swift script!

If we can make a bash script, of course we can also make a swift script.

1. Create a file named: hello.swift
```bash
touch hello.swift
```

2. Open and put the following code:
```swift
#!/usr/bin/swift

import Foundation

// Check if there are command-line arguments
guard CommandLine.arguments.count >= 2 else {
    print("Usage: \(CommandLine.arguments[0]) <name>")
    exit(1)
}

// Get the name argument
let name = CommandLine.arguments[1]

// Print the greeting
print("Hello \(name)!")

```

3. Make it executable:
```bash
chmod +x hello.swift
```

4. Done!

Note: It will run slow on initial build.
