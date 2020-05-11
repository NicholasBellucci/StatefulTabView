//
//  Tab+Modifiers.swift
//
//
//  Created by Nicholas Bellucci on 5/10/20.
//

import SwiftUI

public extension Tab {
    func barItem(title: String, imageName: String) -> Tab {
        var copy = self
        copy.barItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage:nil)
        return copy
    }
    
    func barItem(title: String, systemImageName: String) -> Tab {
        var copy = self
        copy.barItem = UITabBarItem(title: title, image: UIImage(systemName: systemImageName), selectedImage: nil)
        return copy
    }
    
    func barItem(title: String, image: UIImage?) -> Tab {
        var copy = self
        copy.barItem = UITabBarItem(title: title, image: image, selectedImage: nil)
        return copy
    }
}
