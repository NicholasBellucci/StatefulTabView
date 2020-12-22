//
//  StatefulTabView+Modifiers.swift
//
//
//  Created by Nicholas Bellucci on 5/10/20.
//

import SwiftUI

public extension StatefulTabView {
    func barBackgroundColor(_ color: UIColor) -> StatefulTabView {
        var copy = self
        copy.backgroundColor = color
        return copy
    }
    
    func selectedItemConfiguration(_ configuration: TabBarItemConfiguration) -> StatefulTabView {
        var copy = self
        copy.selectedItemConfiguration = configuration
        return copy
    }
    
    func unselectedItemConfiguration(_ configuration: TabBarItemConfiguration) -> StatefulTabView {
        var copy = self
        copy.unselectedItemConfiguration = configuration
        return copy
    }
    
    func barAppearanceConfiguration(_ configuration: TabBarBackgroundConfiguration) -> StatefulTabView {
        var copy = self
        copy.tabBarConfiguration = configuration
        return copy
    }
}
