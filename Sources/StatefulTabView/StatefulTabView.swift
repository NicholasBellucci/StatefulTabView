import SwiftUI

public struct StatefulTabView: View {
    var viewControllers: [UIHostingController<Tab>] = []
    var backgroundColor: UIColor? = nil
    
    @State var selectedIndex: Int = 0
    
    public init(@ViewBuilder tabs: () -> TupleView<(Tab)>) {
        let tuple = tabs().value
        let tupleMirror = Mirror(reflecting: tuple)
        
        tupleMirror.children.forEach {
            if let tab = $0.value as? Tab {
                let tabController = UIHostingController(rootView: tab)
                tabController.tabBarItem = tab.barItem
                viewControllers.append(tabController)
            }
        }
    }
    
    init(@ViewBuilder tabs: () -> TupleView<(Tab, Tab)>) {
        let tuple = tabs().value
        let tupleMirror = Mirror(reflecting: tuple)
        
        tupleMirror.children.forEach {
            if let tab = $0.value as? Tab {
                let tabController = UIHostingController(rootView: tab)
                tabController.tabBarItem = tab.barItem
                viewControllers.append(tabController)
            }
        }
    }
    
    init(@ViewBuilder tabs: () -> TupleView<(Tab, Tab, Tab)>) {
        let tuple = tabs().value
        let tupleMirror = Mirror(reflecting: tuple)
        
        tupleMirror.children.forEach {
            if let tab = $0.value as? Tab {
                let tabController = UIHostingController(rootView: tab)
                tabController.tabBarItem = tab.barItem
                viewControllers.append(tabController)
            }
        }
    }
    
    init(@ViewBuilder tabs: () -> TupleView<(Tab, Tab, Tab, Tab)>) {
        let tuple = tabs().value
        let tupleMirror = Mirror(reflecting: tuple)
        
        tupleMirror.children.forEach {
            if let tab = $0.value as? Tab {
                let tabController = UIHostingController(rootView: tab)
                tabController.tabBarItem = tab.barItem
                viewControllers.append(tabController)
            }
        }
    }
    
    init(@ViewBuilder tabs: () -> TupleView<(Tab, Tab, Tab, Tab, Tab)>) {
        let tuple = tabs().value
        let tupleMirror = Mirror(reflecting: tuple)
        
        tupleMirror.children.forEach {
            if let tab = $0.value as? Tab {
                let tabController = UIHostingController(rootView: tab)
                tabController.tabBarItem = tab.barItem
                viewControllers.append(tabController)
            }
        }
    }
    
    init(@ViewBuilder tabs: () -> TupleView<(Tab, Tab, Tab, Tab, Tab, Tab)>) {
        let tuple = tabs().value
        let tupleMirror = Mirror(reflecting: tuple)
        
        tupleMirror.children.forEach {
            if let tab = $0.value as? Tab {
                let tabController = UIHostingController(rootView: tab)
                tabController.tabBarItem = tab.barItem
                viewControllers.append(tabController)
            }
        }
    }
    
    public var body: some View {
        TabBarController(controllers: viewControllers, backgroundColor: backgroundColor, selectedIndex: $selectedIndex)
            .edgesIgnoringSafeArea(.all)
    }
}

public extension StatefulTabView {
    func tabBarBackgroundColor(_ color: UIColor) -> StatefulTabView {
        var copy = self
        copy.backgroundColor = color
        return copy
    }
}
