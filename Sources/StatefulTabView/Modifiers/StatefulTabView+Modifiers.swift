//
//  StatefulTabView+Modifiers.swift
//
//
//  Created by Nicholas Bellucci on 5/10/20.
//

import SwiftUI

public extension StatefulTabView {
    func barTintColor(_ color: UIColor) -> StatefulTabView {
        var copy = self
        copy.barTintColor = color
        return copy
    }

    func unselectedItemTintColor(_ color: UIColor) -> StatefulTabView {
        var copy = self
        copy.unselectedItemTintColor = color
        return copy
    }
    
    func barBackgroundColor(_ color: UIColor) -> StatefulTabView {
        var copy = self
        copy.backgroundColor = color
        return copy
    }
    
    func barAppearanceConfiguration(_ configuration: TabBarBackgroundConfiguration) -> StatefulTabView {
        var copy = self
        copy.tabBarConfiguration = configuration
        return copy
    }
    
    func unselectedItemFont(_ font: UIFont?) -> StatefulTabView {
        var copy = self
        copy.unselectedItemFont = font
        return copy
    }
    
    func selectedItemFont(_ font: UIFont?) -> StatefulTabView {
        var copy = self
        copy.selectedItemFont = font
        return copy
    }
    
    func badgeFont(_ font: UIFont?) -> StatefulTabView {
        var copy = self
        copy.badgeFont = font
        return copy
    }
    
    func badgeOffset(_ offset: UIOffset) -> StatefulTabView {
        var copy = self
        copy.badgeOffset = offset
        return copy
    }
}
