//
//  TabBarController.swift
//
//
//  Created by Nicholas Bellucci on 5/8/20.
//

import SwiftUI

public enum TabBarBackgroundConfiguration {
    case `default`
    case opaque
    case transparent
}

struct TabBarController: UIViewControllerRepresentable {
    var controllers: [UIViewController]
    
    var barTintColor: UIColor?
    var backgroundColor: UIColor?
    var tabBarConfiguration: TabBarBackgroundConfiguration?
    
    @Binding var selectedIndex: Int

    func makeUIViewController(context: Context) -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = controllers
        tabBarController.delegate = context.coordinator
        tabBarController.selectedIndex = 0
        
        configure(tabBarController.tabBar)
        return tabBarController
    }

    func updateUIViewController(_ tabBarController: UITabBarController, context: Context) {
        tabBarController.selectedIndex = selectedIndex
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITabBarControllerDelegate {
        var parent: TabBarController

        init(_ tabBarController: TabBarController) {
            self.parent = tabBarController
        }
        
        func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            parent.selectedIndex = tabBarController.selectedIndex
        }
    }
}

private extension TabBarController {
    func configure(_ tabBar: UITabBar) {
        let appearance = tabBar.standardAppearance.copy()
        
        if let config = tabBarConfiguration {
            switch config {
            case .default:
                appearance.configureWithDefaultBackground()
            case .opaque:
                appearance.configureWithOpaqueBackground()
            case .transparent:
                appearance.configureWithTransparentBackground()
            }
        }
        
        if let barTintColor = barTintColor {
            tabBar.tintColor = barTintColor
        }
        
        if let backgroundColor = backgroundColor {
            tabBar.backgroundColor = backgroundColor
        }
        
        tabBar.standardAppearance = appearance
    }
}
