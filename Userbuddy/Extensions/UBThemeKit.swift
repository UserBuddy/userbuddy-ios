//
//  UBButton.swift
//  Userbuddy
//
//  Created by Ryan Bliss on 5/7/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import UIKit

extension UIButton {
    func apply(theme: UBButtonTheme) {
        self.backgroundColor = theme.background
        self.setTitleColor(theme.text.color, for: .normal)
        self.titleLabel?.font =  theme.text.font
    }
}

extension UILabel {
    func apply(theme: UBTextTheme) {
        self.font = theme.font
        self.textColor = theme.color
    }
}
