//
//  UBChoiceOption.swift
//  Userbuddy
//
//  Created by Ryan Bliss on 5/7/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import UIKit

class UBChoiceOption: UIView {

    @IBOutlet var optionIdLabel: UILabel!
    
    @IBOutlet var optionButton: UIButton!
    
    @IBAction func onSelect(_ sender: Any) {
        if let onSelect = _onSelect {
            if isSelected {
                onSelect(nil)
                return
            }
            onSelect(_optionText)
        }
    }
    
    var isSelected: Bool {
        get {
            if let selected = _currentSelected {
                if selected == _optionText {
                    return true
                }
            }
            return false
        }
    }
    var _currentSelected: String?
    var _optionText: String = ""
    var _onSelect: ((String?) -> Void)?
    
    func setProperties(optionId: String, optionText: String, onSelect: @escaping (String?) -> Void) {
        self.optionIdLabel.text = optionId
        self.optionIdLabel.textColor = Userbuddy.theme.subtitle.color
        self._onSelect = onSelect
        self.optionButton.setTitle(optionText, for: .normal)
        self._optionText = optionText
    }
    
    func updateSelected(option: String?) {
        self._currentSelected = option
        if isSelected {
            optionButton.apply(theme: Userbuddy.theme.multipleChoiceButton.focus)
        } else {
            optionButton.apply(theme: Userbuddy.theme.multipleChoiceButton.idle)
        }
    }
}
