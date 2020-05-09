//
//  TabBarController.swift
//  
//
//  Created by Nicholas Bellucci on 5/8/20.
//

import SwiftUI

struct TabBarController: UIViewControllerRepresentable {
    var controllers: [UIViewController]
    var backgroundColor: UIColor?
    @Binding var selectedIndex: Int

    func makeUIViewController(context: Context) -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = controllers
        tabBarController.delegate = context.coordinator
        tabBarController.selectedIndex = 0
        
        let appearance = tabBarController.tabBar.standardAppearance.copy()
        appearance.configureWithTransparentBackground()
        tabBarController.tabBar.standardAppearance = appearance
        
        if let color = backgroundColor {
            tabBarController.tabBar.backgroundColor = color
        }
        
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
            if parent.selectedIndex == tabBarController.selectedIndex {
                print("root")
                parent.controllers[tabBarController.selectedIndex].view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            } else {
                parent.selectedIndex = tabBarController.selectedIndex
            }
        }
    }
}
