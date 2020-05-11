# StatefulTabView

A SwiftUI UITabBarController implementation that retains state between tab changes.

#### Requirements
- iOS 13.0+
- Xcode 11.2+
- Swift 5+

## Installation

### Swift Package Manager
In Xcode 11 or greater, navigate to `File > Swift Packages > Add Package Dependency...`. From there just simply add `https://github.com/NicholasBellucci/StatefulTabView` as the package repository url and use the master branch or the most recent version. Master will always be inline with the newest release.

## Table of Contents
   * [Features](#features)
   * [Usage](#usage)

## Features
- [x] State driven selected index
- [x] TabBar appearance configuration
- [x] TabBar custom tint color
- [x] TabBar custom background color
- [x] TabBarItem custom title and image
- [x] TabBarItem badge value
- [x] State retention from tab to tab
- [x] Pop to root functionality when clicking selected index

## Usage

Setting up StatefulTabView is reletively simple and works similar to the native TabView. The main difference is that the content of the tabs is wrapped in a Tab struct. There is no limitation on how many tabs can be used. Once more than 5 are used, the Apple standard more tab will become available. Feel free to check out the example project for the exact usage.

### Basic
```Swift
StatefulTabView(selectedIndex: $selectedIndex) {
    Tab(title: "Tab 1", systemImageName: "circle.fill") {
        NavigationView {
            List {
                Section {
                    ForEach(0..<20, id: \.self) { index in
                        NavigationLink(destination: PushedView(text: "Pushed number \(index)")) {
                            Text("\(index)")
                        }
                    }
                }
            }
            .navigationBarTitle("Navigation View 1")
        }
    }
}
```

### Appearance Modifications

All appearance modifications can be made by using extensions for the StatefulTabView.

```Swift
StatefulTabView(selectedIndex: $selectedIndex) {
    ...
}
.barTintColor(.red)
.barBackgroundColor(.yellow)
.barAppearanceConfiguration(.transparent)
```

### BadgeValue

The TabBarItem badge value can be set in the initializer of a Tab. The passed value is a binding.

```Swift
Tab(title: "Tab 1", systemImageName: "circle.fill", badgeValue: $badgeValue) {
    ...
}
```

## License

StatefulTabView is, and always will be, MIT licensed. See [LICENSE](LICENSE) for details.
