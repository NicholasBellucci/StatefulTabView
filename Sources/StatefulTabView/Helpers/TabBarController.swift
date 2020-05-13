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
            guard let navigationController = navigationController(in: viewController)  else {
                return
            }
            
            if navigationController.children.count == 1 {
                scrollScrollViewToTop(in: navigationController)
            } else {
                navigationController.popToRootViewController(animated: true)
            }
        }
        
        func scrollScrollViewToTop(in navigationController: UINavigationController) {
            let views = navigationController.viewControllers.map { $0.view.subviews }.reduce([], +)
            if let scrollView = scrollView(in: views) {
                scrollView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
            }
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
    func navigationController(in viewController: UIViewController) -> UINavigationController? {
        var controller: UINavigationController?
        
        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }
        
        viewController.children.forEach {
            if let navigationController = $0 as? UINavigationController {
                controller = navigationController
            } else {
                controller = navigationController(in: $0)
            }
        }
        
        return controller
    }
    
    func scrollView(in views: [UIView]) -> UIScrollView? {
        var view: UIScrollView?
        
        views.forEach {
            if let scrollView = $0 as? UIScrollView {
                view = scrollView
            } else {
                view = scrollView(in: $0.subviews)
            }
        }
        
        return view
    }
}
