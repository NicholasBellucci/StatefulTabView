//
//  Tab.swift
//
//
//  Created by Nicholas Bellucci on 5/8/20.
//

import SwiftUI

public struct Tab: View {
    var view: AnyView
    var barItem: UITabBarItem? = nil
    
    public init<T>(@ViewBuilder content: @escaping () -> T) where T: View {
        self.view = AnyView(content())
    }
    
    public var body: some View {
        self.view
    }
}
