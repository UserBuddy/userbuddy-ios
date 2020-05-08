//
//  UBDeviceTheme.swift
//  Userbuddy
//
//  Created by Ryan Bliss on 5/7/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import UIKit

enum UBUserInterfaceStyle {
    case light
    case dark
}

class UBDeviceTheme {
    static var current: UBUserInterfaceStyle {
        get {
            if #available(iOS 13.0, *) {
                if UITraitCollection.current.userInterfaceStyle == .dark {
                    return .dark
                }
                else {
                    return .light
                }
            }
            
            return .light
        }
    }
}
