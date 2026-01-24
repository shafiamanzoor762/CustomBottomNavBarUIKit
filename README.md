# Custom Bottom Navigation Bars – UIKit

A collection of **stylish, animated custom bottom tab bars** built using **UIKit**, `UIBezierPath`, and smooth spring animations.

This project demonstrates how to completely replace `UITabBar` with fully custom, highly interactive navigation bars.

---
### Project Structure
![Project Structure](Screenshots/project_structure.png)

## ✨ Features

### 🔹 Inner Curved Tab Bar
- Custom drawn **inner upward bump** using `UIBezierPath`
- Smooth selection animations with spring effect
- SF Symbols support (filled / unfilled states)
- Fully programmatic (no Storyboards)
- Clean auto-layout with zero constraint conflicts

### 🔹 Wave / Floating Tab Bar
- Ultra-smooth **wave-style bump**
- Rounded top corners
- Shadow & elevation effect
- Scalable animated icons
- Custom image assets support

---

## 📱 Preview

### Inner Curved Tab Bar
![Inner Curved Tab Bar](Screenshots/inner_curved_tabbar.gif)

### Wave Style Custom Tab Bar
![Custom Tab Bar](Screenshots/custom_tabbar.gif)

---

## 🛠 Requirements
- iOS 13+
- Swift 5+
- UIKit
- Xcode 14+

---

## 🚀 Usage

### Step 1: Choose a Tab Bar Controller

```swift
window.rootViewController = CustomTabBarController()
// OR
window.rootViewController = InnerCurvedTabBarController()
