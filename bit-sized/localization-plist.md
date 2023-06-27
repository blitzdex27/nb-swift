# Localization of Plist in iOS Development

## Method 1 - Using Info.plist file

1. On your project navigator, select the Info.plist file.
2. From the inspector phane, select "Localize".
3. Select the language you want to add for localization.
4. Additional file for that language will be created, modify the contents based on your requirement.

## Method 2 - Using InfoPlist.strings file

1. Create a file named "InfoPlist.strings".
2. On this file, add your key-value entries<sup>[1]</sup> (e.g. NSFaceIDUsageDescription = "The app needs permission to access your Face ID to log in";)
3. On your project navigator, select the InfoPlist file and and localize using the inspector phane.

Notes:
<sup>[1]</sup> The key should be in raw form. Right-click on the key and select "Raw Keys and Values".


