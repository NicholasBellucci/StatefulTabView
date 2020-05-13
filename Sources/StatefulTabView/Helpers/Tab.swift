//
//  Tab.swift
//
//
//  Created by Nicholas Bellucci on 5/8/20.
//

import SwiftUI

public struct Tab {
    var view: AnyView
    var barItem: UITabBarItem? = nil
    
    internal var prefersLargeTitle: Bool = false
    
    @Binding var badgeValue: String?
    
    public init<T>(title: String,
                   imageName: String,
                   badgeValue: Binding<String?> = .constant(nil),
                   @ViewBuilder content: @escaping () -> T) where T: View {
        
        _badgeValue = badgeValue
        barItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: nil)
        
        self.view = AnyView(content())
    }
    
    public init<T>(title: String,
                   systemImageName: String,
                   badgeValue: Binding<String?> = .constant(nil),
                   @ViewBuilder content: @escaping () -> T) where T: View {
        
        _badgeValue = badgeValue
        barItem = UITabBarItem(title: title, image: UIImage(systemName: systemImageName), selectedImage: nil)
        
        self.view = AnyView(content())
    }
    
    public init<T>(title: String,
                   image: UIImage?,
                   badgeValue: Binding<String?> = .constant(nil),
                   @ViewBuilder content: @escaping () -> T) where T: View {
        
        _badgeValue = badgeValue
        barItem = UITabBarItem(title: title, image: image, selectedImage: nil)
        
        self.view = AnyView(content())
    }
}
