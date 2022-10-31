//
//  TabBarCoordinator.swift
//  Example
//
//  Created by Nicholas Bellucci on 5/13/20.
//  Copyright © 2020 Nicholas Bellucci. All rights reserved.
//

import SwiftUI

class TabBarCoordinator: NSObject, UITabBarControllerDelegate {
    private enum Constants {
        static let boundsContainsPoint = CGPoint(x: 0, y: -89)
        static let largeTitleRect = CGRect(x: 0, y: -52, width: 1, height: 1)
        static let inlineTitleRect = CGRect(x: 0, y: 0, width: 1, height: 1)
    }
    
    var parent: TabBarController

    init(_ tabBarController: TabBarController) {
        self.parent = tabBarController
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if parent.selectedIndex == tabBarController.selectedIndex {
            guard let navigationController = navigationController(in: viewController)  else {
                scrollToTop(in: viewController)
                return
            }
            
            if navigationController.visibleViewController == navigationController.viewControllers.first {
                scrollToTop(in: navigationController, selectedIndex: tabBarController.selectedIndex)
            } else {
                navigationController.popToRootViewController(animated: true)
            }
        }

        parent.selectedIndex = tabBarController.selectedIndex
    }
}

private extension TabBarCoordinator {
    func scrollToTop(in navigationController: UINavigationController, selectedIndex: Int) {
        let views = navigationController.viewControllers
            .map { $0.view.subviews }
            .reduce([], +)
        
        if let scrollView = scrollView(in: views) {
            if parent.tabBarItems[selectedIndex].prefersLargeTitle {
                if !scrollView.bounds.contains(Constants.boundsContainsPoint) {
                    scrollView.scrollRectToVisible(Constants.largeTitleRect, animated: true)
                }
            } else {
                scrollView.scrollRectToVisible(Constants.inlineTitleRect, animated: true)
            }
        }
    }
    
    func scrollToTop(in viewController: UIViewController) {
        let views = viewController.view.subviews
        
        if let scrollView = scrollView(in: views) {
            scrollView.scrollRectToVisible(Constants.inlineTitleRect, animated: true)
        }
    }
}

private extension TabBarCoordinator {
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
            guard view == nil else {
                return
            }

            if let scrollView = $0 as? UIScrollView {
                view = scrollView
            } else {
                view = scrollView(in: $0.subviews)
            }
        }
        
        return view
    }
}
