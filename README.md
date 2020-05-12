# StatefulTabView

A SwiftUI UITabBarController implementation that retains state between tab changes. Big thanks to [Amzd](https://gist.github.com/Amzd) and everyone who helped to refine this [gist](https://gist.github.com/Amzd/2eb5b941865e8c5cccf149e6e07c8810) as it was a major jumping off point for setting up this project.

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
- [x] Pop to root functionality when selecting the already selected tab

## Usage

Setting up StatefulTabView is relatively simple and works similar to the native TabView. The main difference is that the content of the tabs is wrapped in a Tab struct. There is no limitation on how many tabs can be used. Once more than 5 are used, the Apple standard more tab will become available. Feel free to check out the example project for the exact usage.

### Basic
```Swift
StatefulTabView {
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
StatefulTabView {
    ...
}
.barTintColor(.red)
.barBackgroundColor(.yellow)
.barAppearanceConfiguration(.transparent)
```

### Selected Index

The selected index of the StatefulTabView can be set within the initializer. The passed value is a binding.

```Swift
StatefulTabView(selectedIndex: $selectedIndex) {
    ...
}
```

### BadgeValue

The TabBarItem badge value can be set in the initializer of a Tab. The passed value is a binding.

```Swift
Tab(title: "Tab 1", systemImageName: "circle.fill", badgeValue: $badgeValue) {
    ...
}
```

### Single Tab

Due to the limitations of the current `@_functionBuilder` implementation in Swift, to build a StatefulTabView with one tab `BuilderType.individual`, should be passed within the initializer.

```Swift
StatefulTabView(.individual) {
    Tab(title: "Tab 1", systemImageName: "circle.fill") {
        ...
    }
}
```

## License

StatefulTabView is, and always will be, MIT licensed. See [LICENSE](LICENSE) for details.
