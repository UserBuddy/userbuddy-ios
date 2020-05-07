//
//  UBThumbRating.swift
//  UserBuddy
//
//  Created by Ryan Bliss on 5/4/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import UIKit

class UBThumbRating: UIView {

    @IBOutlet weak var questionTitle: UILabel!
    var questionText: String = "" {
       didSet {
          questionTitle.text = questionText
          questionTitle.sizeToFit()
       }
    }
    
    @IBOutlet weak var thumbsDownButton: UIButton!
    @IBAction func pressThumbsDown(_ sender: Any) {
        if let _onPress = _onPress {
            _onPress(false)
        }
    }
    
    @IBOutlet weak var thumbsUpButton: UIButton!
    @IBAction func pressThumbsUp(_ sender: Any) {
        if let _onPress = _onPress {
            _onPress(true)
        }
    }
    
    var _onPress: ((Bool) -> Void)?
    
    func setProperties(question: UBQuestion, onPress: @escaping (Bool) -> Void) {
        self.questionText = question.title
        self._onPress = onPress
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
