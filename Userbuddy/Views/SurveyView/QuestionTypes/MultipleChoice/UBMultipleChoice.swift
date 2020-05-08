//
//  UBMultipleChoice.swift
//  Userbuddy
//
//  Created by Ryan Bliss on 5/7/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import UIKit

class UBMultipleChoice: UIView {

    @IBOutlet var title: UILabel!
    
    @IBOutlet var stackView: UIStackView!
    
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var noThanksButton: UIButton!
    
    @IBAction func onDismiss(_ sender: Any) {
        if let _onPress = _onPress {
            _onPress(_selectedOption)
        }
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        if let _onPress = _onPress {
            if let question = _question {
                if question.required && _selectedOption.count == 0 {
                    return;
                }
            }
            _onPress(_selectedOption)
        }
    }
    
    var _selectedOption: String {
        get {
            if let option = selectedOption {
                return option
            }
            return ""
        }
    }
    var selectedOption: String?
    var _question: UBQuestion?
    var _onPress: ((String) -> Void)?
    
    func setProperties(question: UBQuestion, onPress: @escaping (String) -> Void) {
        self.title.text = question.title
        self._onPress = onPress
        self._question = question
        if (question.required) {
            self.noThanksButton.removeFromSuperview()
        }
        stackView.arrangedSubviews.forEach { (sv) in
            sv.removeFromSuperview()
        }
        
        let setSelected: (String?) -> Void = { (newSelected) in
            self.selectedOption = newSelected
            self.stackView.arrangedSubviews.forEach { (optionView) in
                if let optionView = optionView as? UBChoiceOption {
                    optionView.updateSelected(option: newSelected)
                }
            }
        }
        
        if let options = question.options {
            let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            options.enumerated().forEach { (index, option) in
                let optionView = UIView.initialize(using: "UBChoiceOption", frame: CGRect(x: 0, y:0, width: bounds.width, height: 56))
                if let optionView = optionView as? UBChoiceOption {
                    
                    let optionId = options.count <= alphabet.count
                        ? "\(alphabet[index])."
                        : "\(index + 1)."
                        
                    optionView.setProperties(optionId: optionId, optionText: option, onSelect: setSelected)
                    stackView.addArrangedSubview(optionView)
                }
            }
        }
    }
    
    // MARK: - Required random stuff
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
       // For use in Interface Builder
       super.init(coder: aDecoder)
    }
    
    
}
