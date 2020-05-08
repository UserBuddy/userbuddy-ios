//
//  UBTextInput.swift
//  UserBuddy
//
//  Created by Ryan Bliss on 5/4/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

//
//  UBThumbRating.swift
//  UserBuddy
//
//  Created by Ryan Bliss on 5/4/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import UIKit

class UBTextInput: UIView {
    
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var textInputView: UITextView!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBAction func pressSubmit(_ sender: Any) {
        if let _onPress = _onPress {
            if let question = _question {
                if question.required && textInputView.text.count == 0 {
                    return;
                }
            }
            _onPress(textInputView.text)
        }
    }
    
    @IBOutlet weak var noThanksButton: UIButton!
    @IBAction func pressNoThanks(_ sender: Any) {
        if let _onPress = _onPress {
            _onPress(textInputView.text)
        }
    }
    
    
    var _question: UBQuestion?
    var _onPress: ((String) -> Void)?
    
    func setProperties(question: UBQuestion, onPress: @escaping (String) -> Void) {
        self.questionTitle.text = question.title
        self.questionTitle.apply(theme: Userbuddy.theme.title)
        
        self.submitButton.apply(theme: Userbuddy.theme.primaryButton)
        self.noThanksButton.apply(theme: Userbuddy.theme.secondaryButton)
        
        self._onPress = onPress
        self._question = question
        if (question.required) {
            self.noThanksButton.removeFromSuperview()
        }
        self.textInputView.becomeFirstResponder()
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
