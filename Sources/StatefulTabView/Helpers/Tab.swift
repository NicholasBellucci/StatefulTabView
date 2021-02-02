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
    public init<T>(title: String? = nil,
                   imageName: String,
                   selectedImageName: String? = nil,
                   badgeValue: String? = nil,
                   @ViewBuilder content: @escaping () -> T) where T: View {
        
        self.badgeValue = badgeValue
        
        var selectedImage: UIImage?
        if let selectedImageName = selectedImageName {
            selectedImage = UIImage(named: selectedImageName)
        }
        
        barItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: selectedImage)
        
        self.view = AnyView(content())
    }
    
    // MARK: System Image Names
    public init<T>(title: String? = nil,
                   systemImageName: String,
                   selectedSystemImageName: String? = nil,
                   badgeValue: String? = nil,
                   @ViewBuilder content: @escaping () -> T) where T: View {
        
        self.badgeValue = badgeValue
        
        var selectedImage: UIImage?
        
        if let selectedSystemImageName = selectedSystemImageName {
            selectedImage = UIImage(systemName: selectedSystemImageName)
        }
        
        barItem = UITabBarItem(title: title, image: UIImage(systemName: systemImageName), selectedImage: selectedImage)
        
        self.view = AnyView(content())
    }
    
    // MARK: UIImages
    public init<T>(title: String? = nil,
                   image: UIImage?,
                   selectedImage: UIImage? = nil,
                   badgeValue: String? = nil,
                   @ViewBuilder content: @escaping () -> T) where T: View {
        
        self.badgeValue = badgeValue
        
        barItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        
        self.view = AnyView(content())
    }
}
