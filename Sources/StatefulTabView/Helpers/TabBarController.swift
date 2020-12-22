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

public struct TabBarItemConfiguration {
    public var titleFont: UIFont
    public var titleColor: UIColor
    public var iconColor: UIColor
    public var badgeFont: UIFont
    public var badgeTextColor: UIColor
    public var badgeBackgroundColor: UIColor
    public var badgeOffset: UIOffset
    
    public init(titleFont: UIFont, titleColor: UIColor, iconColor: UIColor, badgeFont: UIFont, badgeTextColor: UIColor, badgeBackgroundColor: UIColor, badgeOffset: UIOffset? = .zero) {
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.iconColor = iconColor
        self.badgeFont = badgeFont
        self.badgeTextColor = badgeTextColor
        self.badgeBackgroundColor = badgeBackgroundColor
        self.badgeOffset = badgeOffset ?? .zero
    }
}

struct TabBarController: UIViewControllerRepresentable {
    var controllers: [UIViewController]
    var tabBarItems: [Tab]
    
    var backgroundColor: UIColor?
    var selectedItemConfiguration: TabBarItemConfiguration?
    var unselectedItemConfiguration: TabBarItemConfiguration?
    
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
    
    func makeCoordinator() -> TabBarCoordinator {
        TabBarCoordinator(self)
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
        
        if let backgroundColor = backgroundColor {
            tabBar.backgroundColor = backgroundColor
        }
        
        if let conf = unselectedItemConfiguration {
            tabBar.tintColor = conf.titleColor
            
            if #available(iOS 13.0, *) {
                appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                    .font: conf.titleFont,
                    .foregroundColor: conf.titleColor
                ]
                appearance.stackedLayoutAppearance.normal.badgeTextAttributes = [
                    .font: conf.badgeFont,
                    .foregroundColor: conf.badgeTextColor
                ]
                appearance.stackedLayoutAppearance.normal.iconColor = conf.iconColor
                appearance.stackedLayoutAppearance.normal.badgeBackgroundColor = conf.badgeBackgroundColor
                appearance.stackedLayoutAppearance.normal.badgePositionAdjustment = conf.badgeOffset
                
                appearance.inlineLayoutAppearance.normal.titleTextAttributes = appearance.stackedLayoutAppearance.normal.titleTextAttributes
                appearance.inlineLayoutAppearance.normal.badgeTextAttributes = appearance.stackedLayoutAppearance.normal.badgeTextAttributes
                appearance.inlineLayoutAppearance.normal.iconColor = appearance.stackedLayoutAppearance.normal.iconColor
                appearance.inlineLayoutAppearance.normal.badgeBackgroundColor = appearance.stackedLayoutAppearance.normal.badgeBackgroundColor
                
                appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = appearance.stackedLayoutAppearance.normal.titleTextAttributes
                appearance.compactInlineLayoutAppearance.normal.badgeTextAttributes = appearance.stackedLayoutAppearance.normal.badgeTextAttributes
                appearance.compactInlineLayoutAppearance.normal.iconColor = appearance.stackedLayoutAppearance.normal.iconColor
                appearance.compactInlineLayoutAppearance.normal.badgeBackgroundColor = appearance.stackedLayoutAppearance.normal.badgeBackgroundColor
            }
        }
        
        if let conf = selectedItemConfiguration {
            tabBar.tintColor = conf.titleColor
            
            if #available(iOS 13.0, *) {
                appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                    .font: conf.titleFont,
                    .foregroundColor: conf.titleColor
                ]
                appearance.stackedLayoutAppearance.selected.badgeTextAttributes = [
                    .font: conf.badgeFont,
                    .foregroundColor: conf.badgeTextColor
                ]
                appearance.stackedLayoutAppearance.selected.iconColor = conf.iconColor
                appearance.stackedLayoutAppearance.selected.badgeBackgroundColor = conf.badgeBackgroundColor
                appearance.stackedLayoutAppearance.selected.badgePositionAdjustment = conf.badgeOffset
                
                appearance.inlineLayoutAppearance.selected.titleTextAttributes = appearance.stackedLayoutAppearance.selected.titleTextAttributes
                appearance.inlineLayoutAppearance.selected.badgeTextAttributes = appearance.stackedLayoutAppearance.selected.badgeTextAttributes
                appearance.inlineLayoutAppearance.selected.iconColor = appearance.stackedLayoutAppearance.selected.iconColor
                appearance.inlineLayoutAppearance.selected.badgeBackgroundColor = appearance.stackedLayoutAppearance.selected.badgeBackgroundColor
                
                appearance.compactInlineLayoutAppearance.selected.titleTextAttributes = appearance.stackedLayoutAppearance.selected.titleTextAttributes
                appearance.compactInlineLayoutAppearance.selected.badgeTextAttributes = appearance.stackedLayoutAppearance.selected.badgeTextAttributes
                appearance.compactInlineLayoutAppearance.selected.iconColor = appearance.stackedLayoutAppearance.selected.iconColor
                appearance.compactInlineLayoutAppearance.selected.badgeBackgroundColor = appearance.stackedLayoutAppearance.selected.badgeBackgroundColor
            }
        }
        
        tabBar.standardAppearance = appearance
    }
    
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
}
