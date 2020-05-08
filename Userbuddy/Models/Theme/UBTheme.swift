//
//  UBTheme.swift
//  Userbuddy
//
//  Created by Ryan Bliss on 5/7/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import UIKit

public struct UBTheme {
    
    public static var standard: UBTheme {
        get {
            return UBTheme()
        }
    }
    
    let primary: UIColor
    let secondary: UIColor
    
    let title: UBTextTheme
    let subtitle: UBTextTheme
    
    let primaryButton: UBButtonTheme
    let secondaryButton: UBButtonTheme
    let multipleChoiceButton: UBFocusButtonTheme
    
    let card: UIColor
    let divider: UIColor
    
    init(
        primary: UIColor = UIColor.systemBlue,
        secondary: UIColor = UIColor.systemGreen,
        title: UBTextTheme = UBTextTheme(font: UIFont.systemFont(ofSize: 20, weight: .bold), color: UIColor.black),
        subtitle: UBTextTheme = UBTextTheme(font: UIFont.systemFont(ofSize: 17, weight: .regular), color: UIColor.gray),
        primaryButton: UBButtonTheme? = nil,
        secondaryButton: UBButtonTheme? = nil,
        multipleChoiceButton: UBFocusButtonTheme? = nil,
        card: UIColor = UIColor.white,
        divider: UIColor = UIColor.hex("#3C3C43")
    ) {
        self.primary = primary
        self.secondary = secondary
        self.title = title
        self.subtitle = subtitle
        
        if let primaryButton = primaryButton {
            self.primaryButton = primaryButton
        } else {
            self.primaryButton = UBButtonTheme(
                background: primary,
                text: UBTextTheme(
                    font: UIFont.systemFont(ofSize: 15, weight: .semibold),
                    color: UIColor.white
                )
            )
        }
        
        if let secondaryButton = secondaryButton {
            self.secondaryButton = secondaryButton
        } else {
            self.secondaryButton = UBButtonTheme(
                background: UIColor.clear,
                text: UBTextTheme(
                    font: UIFont.systemFont(ofSize: 15, weight: .semibold),
                    color: secondary
                )
            )
        }
        
        if let multipleChoiceButton = multipleChoiceButton {
            self.multipleChoiceButton = multipleChoiceButton
        } else {
            let idle = UBButtonTheme(
                background: UIColor.hex("#F2F2F7"),
                text: UBTextTheme(
                    font: UIFont.systemFont(ofSize: 15, weight: .semibold),
                    color: UIColor.black
                )
            )
            let focus = UBButtonTheme(
                background: primary,
                text: UBTextTheme(
                    font: UIFont.systemFont(ofSize: 15, weight: .semibold),
                    color: UIColor.white
                )
            )
            self.multipleChoiceButton = UBFocusButtonTheme(idle: idle, focus: focus)
        }
        
        self.card = card
        self.divider = divider
    }
}

public struct UBTextTheme {
    let font: UIFont
    let color: UIColor
}

public struct UBFocusButtonTheme {
    let idle: UBButtonTheme
    let focus: UBButtonTheme
}

public struct UBButtonTheme {
    let background: UIColor
    let text: UBTextTheme
}

struct UBThemeInput {
    let background: UIColor
    let idleBorder: UIColor
    let activeBorder: UIColor
    let text: UBTextTheme
    let placeholder: UBTextTheme
}


extension UBTheme {
    var inverted: UBTheme {
        return UBTheme(
            primary: self.primary,
            secondary: self.secondary,
            title: UBTextTheme(font: self.title.font, color: UIColor.white),
            subtitle: UBTextTheme(font: self.subtitle.font, color: UIColor.white.withAlphaComponent(0.9)),
            primaryButton: UBButtonTheme(
                background: UIColor.white,
                text: UBTextTheme(font: self.primaryButton.text.font, color: UIColor.black)
            ),
            secondaryButton: UBButtonTheme(
                background: UIColor.clear,
                text: UBTextTheme(font: self.primaryButton.text.font, color: UIColor.white)
            ),
            multipleChoiceButton: UBFocusButtonTheme(
                idle: UBButtonTheme(
                    background: UIColor.white.withAlphaComponent(0.72),
                    text: UBTextTheme(font: self.multipleChoiceButton.idle.text.font, color: UIColor.black)
                ),
                focus: UBButtonTheme(
                    background: UIColor.white,
                    text: UBTextTheme(font: self.multipleChoiceButton.idle.text.font, color: UIColor.black)
                )
            ),
            card: self.primary,
            divider: UIColor.white.withAlphaComponent(0.72)
        )
    }
}
