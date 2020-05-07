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
    
    convenience init(frame: CGRect, question: UBQuestion, onPress: @escaping (String) -> Void) {
        self.init(frame: frame)
        let bundle = Bundle(for: UBTextInput.self)
        let nib = UINib(nibName: "UBTextInput", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        if let view = view as? UBTextInput {
            view.questionTitle.text = question.title
            
            view._onPress = onPress
            view._question = question
            view.textInputView.becomeFirstResponder()
            
            if (question.required) {
                view.noThanksButton.removeFromSuperview()
            }
        }
        self.addSubview(view)
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
