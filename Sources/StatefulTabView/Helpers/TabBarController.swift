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
    var tabBarItems: [Tab]
    
    var barTintColor: UIColor?
    var backgroundColor: UIColor?
    var tabBarConfiguration: TabBarBackgroundConfiguration?
    
    @Binding var selectedIndex: Int

    func makeUIViewController(context: Context) -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = controllers
        tabBarController.delegate = context.coordinator
        tabBarController.selectedIndex = selectedIndex
        
        configure(tabBarController.tabBar)
        return tabBarController
    }

    func updateUIViewController(_ tabBarController: UITabBarController, context: Context) {
        tabBarController.selectedIndex = selectedIndex
        
        tabBarItems.forEach { tab in
            guard let index = tabBarItems.firstIndex(where: { $0.barItem == tab.barItem }), let controllers = tabBarController.viewControllers else { return }
            
            if controllers.indices.contains(index) {
                controllers[index].tabBarItem.badgeValue = tab.badgeValue
            }
        }
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
            if parent.selectedIndex == tabBarController.selectedIndex {
                popToRootViewController(viewController: viewController)
            }

            parent.selectedIndex = tabBarController.selectedIndex
        }

        func popToRootViewController(viewController: UIViewController) {
            guard let navigationController = navigationController(for: viewController)  else {
                return
            }
            
            navigationController.popToRootViewController(animated: true)
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

private extension TabBarController.Coordinator {
    func navigationController(for viewController: UIViewController) -> UINavigationController? {
        if viewController is UINavigationController {
            return viewController as? UINavigationController
        }
        
        for childViewController in viewController.children {
            if childViewController is UINavigationController {
                return childViewController as? UINavigationController
            }
            
            if childViewController.children.count > 0 {
                if let navigationController = navigationController(for: childViewController) {
                    return navigationController
                }
            }
        }

        return nil
    }
}
