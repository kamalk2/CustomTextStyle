# CustomTextStyle for SwiftUI

A lightweight SwiftUI extension to define and use your own **typographic system** with support for:

- Custom fonts (e.g. AppFont-Regular, AppFont-Bold, etc.)
- Dynamic Type scaling
- Accessibility (large content viewer, adaptive sizing)
- Override support for font size and weight

---

## 🔧 Setup

1. Add your custom fonts (e.g. `AppFont-Regular.ttf`) to your Xcode project
2. Add them to `Info.plist` under `Fonts provided by application`
3. Replace `"AppFont"` in the code with your actual font family name

---

## ✨ Usage

```swift
Text("Hello, World!")
    .textStyle(.title2)

Text("Bold Custom Font")
    .textStyle(.headline, size: 20, weight: .bold)
