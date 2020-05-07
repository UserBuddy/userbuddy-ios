//
//  UBContentLinkView.swift
//  Userbuddy
//
//  Created by Ryan Bliss on 5/6/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import UIKit

class UBContentLinkView: UIView {

    @IBOutlet var title: UILabel!
    var titleText: String = "" {
       didSet {
          title.text = titleText
          title.sizeToFit()
       }
    }
    @IBOutlet var subtitle: UILabel!
    var subtitleText: String = "" {
       didSet {
          subtitle.text = subtitleText
          subtitle.sizeToFit()
       }
    }
    @IBOutlet var ctaButton: UIButton!
    @IBOutlet var dismissButton: UIButton!
    @IBOutlet var bottomMargin: NSLayoutConstraint!
    var bottomMarginValue: CGFloat = 78 {
       didSet {
          bottomMargin.constant = bottomMarginValue
       }
    }
    
    @IBAction func onPressCTA(_ sender: Any) {
        if let onPress = _onPressCTA {
            onPress()
        }
    }
    
    @IBAction func onPressDismiss(_ sender: Any) {
        if let onPress = _onPressDismiss {
            onPress()
        }
    }
    
    var _onPressCTA: (() -> Void)?
    var _onPressDismiss: (() -> Void)?
    
    func setProperties(content: UBContent, pressCTA: @escaping () -> Void, pressDismiss: @escaping () -> Void) {
        self.titleText = content.title
        self.subtitleText = content.subtitle
        
        self._onPressCTA = pressCTA
        
        self._onPressDismiss = pressDismiss
        
        if content.required {
            self.bottomMarginValue = 28
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
