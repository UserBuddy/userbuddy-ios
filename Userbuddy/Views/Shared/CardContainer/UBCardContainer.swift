//
//  UBCardContainer.swift
//  UserBuddy
//
//  Created by Ryan Bliss on 5/4/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import UIKit

class UBCardContainer: UIView {

    @IBOutlet weak var cardContent: UIView!
    
    var cardContainer: UBCardContainer?
    
    override init(frame: CGRect) {
         super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, innerContent: UIView?) {
        // For use in code
        self.init(frame: frame)
        
        let bundle = Bundle(for: UBCardContainer.self)
        let nib = UINib(nibName: "UBCardContainer", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.layer.cornerRadius = 16
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.12
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 2
        
        if let view = view as? UBCardContainer {
            self.cardContainer = view
            if let innerContent = innerContent {
                self.setInnerContent(innerContent)
            }
        }
        
        self.addSubview(view)
    }
    
    public func setInnerContent(_ innerContent: UIView) {
        if let cardContainer = cardContainer {
            cardContainer.subviews.forEach { (subview) in
                subview.removeFromSuperview()
            }
            innerContent.frame = cardContainer.bounds
            cardContainer.addSubview(innerContent)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
       // For use in Interface Builder
       super.init(coder: aDecoder)
    }

}
