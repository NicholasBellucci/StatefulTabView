//
//  StatefulTabView.swift
//
//
//  Created by Nicholas Bellucci on 5/10/20.
//

import SwiftUI

public struct StatefulTabView: View {
    internal var viewControllers: [UIHostingController<Tab>] = []
    
    internal var barTintColor: UIColor? = nil
    internal var backgroundColor: UIColor? = nil
    internal var tabBarConfiguration: TabBarBackgroundConfiguration? = nil
    
    @Binding internal var selectedIndex: Int
    
    init(selectedIndex: Binding<Int> = .constant(0), @ViewBuilder tab: () -> Tab) {
        _selectedIndex = selectedIndex
        
        let tabController = UIHostingController(rootView: tab())
        tabController.tabBarItem = tab().barItem
        viewControllers.append(tabController)
    }
    
    init(selectedIndex: Binding<Int> = .constant(0), @ViewBuilder tabs: () -> TupleView<(Tab, Tab)>) {
        _selectedIndex = selectedIndex
        
        let tuple = tabs().value
        let tupleMirror = Mirror(reflecting: tuple)
        configureViewControllers(with: tupleMirror)
    }
    
    init(selectedIndex: Binding<Int> = .constant(0), @ViewBuilder tabs: () -> TupleView<(Tab, Tab, Tab)>) {
        _selectedIndex = selectedIndex
        
        let tuple = tabs().value
        let tupleMirror = Mirror(reflecting: tuple)
        configureViewControllers(with: tupleMirror)
    }
    
    init(selectedIndex: Binding<Int> = .constant(0), @ViewBuilder tabs: () -> TupleView<(Tab, Tab, Tab, Tab)>) {
        _selectedIndex = selectedIndex
        
        let tuple = tabs().value
        let tupleMirror = Mirror(reflecting: tuple)
        configureViewControllers(with: tupleMirror)
    }
    
    init(selectedIndex: Binding<Int> = .constant(0), @ViewBuilder tabs: () -> TupleView<(Tab, Tab, Tab, Tab, Tab)>) {
        _selectedIndex = selectedIndex
        
        let tuple = tabs().value
        let tupleMirror = Mirror(reflecting: tuple)
        configureViewControllers(with: tupleMirror)
    }
    
    init(selectedIndex: Binding<Int> = .constant(0), @ViewBuilder tabs: () -> TupleView<(Tab, Tab, Tab, Tab, Tab, Tab)>) {
        _selectedIndex = selectedIndex
        
        let tuple = tabs().value
        let tupleMirror = Mirror(reflecting: tuple)
        configureViewControllers(with: tupleMirror)
    }
    
    public var body: some View {
        TabBarController(controllers: viewControllers,
                         barTintColor: barTintColor,
                         backgroundColor: backgroundColor,
                         tabBarConfiguration: tabBarConfiguration,
                         selectedIndex: $selectedIndex)
            .edgesIgnoringSafeArea(.all)
    }
}

private extension StatefulTabView {
    mutating func configureViewControllers(with mirror: Mirror) {
        mirror.children.forEach {
            if let tab = $0.value as? Tab {
                let tabController = UIHostingController(rootView: tab)
                tabController.tabBarItem = tab.barItem
                viewControllers.append(tabController)
            }
        }
    }
}
