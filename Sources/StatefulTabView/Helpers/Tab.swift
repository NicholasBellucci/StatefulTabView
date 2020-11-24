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
    
    let badgeValue: String?
    
    // MARK: Asset Image Names
    public init<T>(title: String,
                   imageName: String,
                   badgeValue: String? = nil,
                   @ViewBuilder content: @escaping () -> T) where T: View {
        
        self.badgeValue = badgeValue
        barItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: nil)
        
        self.view = AnyView(content())
    }
    
    public init<T>(title: String,
                   selectedImageName: String,
                   unselectedImageName: String,
                   badgeValue: String? = nil,
                   @ViewBuilder content: @escaping () -> T) where T: View {
        
        self.badgeValue = badgeValue
        barItem = UITabBarItem(title: title, image: UIImage(named: unselectedImageName), selectedImage: UIImage(named: selectedImageName))
        
        self.view = AnyView(content())
    }
    
    // MARK: System Image Names
    public init<T>(title: String,
                   systemImageName: String,
                   badgeValue: String? = nil,
                   @ViewBuilder content: @escaping () -> T) where T: View {
        
        self.badgeValue = badgeValue
        barItem = UITabBarItem(title: title, image: UIImage(systemName: systemImageName), selectedImage: nil)
        
        self.view = AnyView(content())
    }
    
    public init<T>(title: String,
                   selectedSystemImageName: String,
                   unselectedSystemImageName: String,
                   badgeValue: String? = nil,
                   @ViewBuilder content: @escaping () -> T) where T: View {
        
        self.badgeValue = badgeValue
        barItem = UITabBarItem(title: title, image: UIImage(systemName: unselectedSystemImageName), selectedImage: UIImage(systemName: selectedSystemImageName))
        
        self.view = AnyView(content())
    }
    
    // MARK: UIImages
    public init<T>(title: String,
                   image: UIImage?,
                   badgeValue: String? = nil,
                   @ViewBuilder content: @escaping () -> T) where T: View {
        
        self.badgeValue = badgeValue
        barItem = UITabBarItem(title: title, image: image, selectedImage: nil)
        
        self.view = AnyView(content())
    }
    
    public init<T>(title: String,
                   image: UIImage?,
                   selectedImage: UIImage?,
                   badgeValue: String? = nil,
                   @ViewBuilder content: @escaping () -> T) where T: View {
        
        self.badgeValue = badgeValue
        barItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        
        self.view = AnyView(content())
    }

}
