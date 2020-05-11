//
//  StatefulTabView.swift
//
//
//  Created by Nicholas Bellucci on 5/10/20.
//

import SwiftUI

public enum BuilderType {
    case individual
}

public struct StatefulTabView: View {
    internal var viewControllers: [UIHostingController<AnyView>] = []
    internal var tabBarItems: [Tab] = []
    
    internal var barTintColor: UIColor? = nil
    internal var backgroundColor: UIColor? = nil
    internal var tabBarConfiguration: TabBarBackgroundConfiguration? = nil
    
    @Binding internal var selectedIndex: Int
    
    init(selectedIndex: Binding<Int> = .constant(0), _ type: BuilderType, _ content: () -> Tab) {
        _selectedIndex = selectedIndex
        
        let tabController = UIHostingController(rootView: content().view)
        tabController.tabBarItem = content().barItem
        viewControllers.append(tabController)
    }
    
    init(selectedIndex: Binding<Int> = .constant(0), @TabBuilder _ content: () -> [Tab]) {
        _selectedIndex = selectedIndex
        configureViewControllers(with: content())
    }
    
    public var body: some View {
        TabBarController(controllers: viewControllers,
                         tabBarItems: tabBarItems,
                         barTintColor: barTintColor,
                         backgroundColor: backgroundColor,
                         tabBarConfiguration: tabBarConfiguration,
                         selectedIndex: $selectedIndex)
            .edgesIgnoringSafeArea(.all)
    }
}

private extension StatefulTabView {
    mutating func configureViewControllers(with tabs: [Tab]) {
        tabs.forEach {
            let tabController = UIHostingController(rootView: $0.view)
            tabController.tabBarItem = $0.barItem
            tabBarItems.append($0)
            viewControllers.append(tabController)
        }
    }
}

@_functionBuilder
public struct TabBuilder {
    public static func buildBlock(_ children: Tab...) -> [Tab] {
        children
    }
}
