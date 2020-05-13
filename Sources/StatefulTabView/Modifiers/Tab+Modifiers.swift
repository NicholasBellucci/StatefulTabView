//
//  Tab+Modifiers.swift
//  Example
//
//  Created by Nicholas Bellucci on 5/13/20.
//  Copyright © 2020 Nicholas Bellucci. All rights reserved.
//

import SwiftUI

public extension Tab {
    func prefersLargeTitle(_ bool: Bool) -> Tab {
        var copy = self
        copy.prefersLargeTitle = bool
        return copy
    }
}
