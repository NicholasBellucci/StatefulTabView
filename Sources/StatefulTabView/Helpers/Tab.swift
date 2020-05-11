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
    
    @Binding var badgeValue: String?
    
    public init<T>(badgeValue: Binding<String?> = .constant(nil), @ViewBuilder content: @escaping () -> T) where T: View {
        _badgeValue = badgeValue
        
        self.view = AnyView(content())
    }
    
    public var body: some View {
        self.view
    }
}
