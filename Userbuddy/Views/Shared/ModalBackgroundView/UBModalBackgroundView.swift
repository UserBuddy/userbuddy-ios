//
//  ModalBackgroundView.swift
//  UserBuddy
//
//  Created by Ryan Bliss on 5/4/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import UIKit

class UBModalBackgroundView: UIView {

    public override init(frame: CGRect) {
        // For use in code
        super.init(frame: frame)
        let bundle = Bundle(for: UBModalBackgroundView.self)
        let nib = UINib(nibName: "UBModalBackgroundView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        let startAlpha: CGFloat = 0
        let endAlpha = view.alpha
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.alpha = startAlpha
        
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame

        view.insertSubview(blurEffectView, at: 0)
        self.addSubview(view)
        
        UIView.animate(withDuration: 0.3) {
            view.alpha = endAlpha
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
       // For use in Interface Builder
       super.init(coder: aDecoder)
    }

}
