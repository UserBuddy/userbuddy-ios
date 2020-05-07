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
    
    convenience init(frame: CGRect, question: UBQuestion, onPress: @escaping (Bool) -> Void) {
        self.init(frame: frame)
        let bundle = Bundle(for: UBThumbRating.self)
        let nib = UINib(nibName: "UBThumbRating", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        if let view = view as? UBThumbRating {
            view.questionText = question.title
            view._onPress = onPress
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
