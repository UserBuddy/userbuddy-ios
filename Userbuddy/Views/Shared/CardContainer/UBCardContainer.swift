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
        
    override init(frame: CGRect) {
         super.init(frame: frame)
    }
    
    public func setInnerContent(_ innerContent: UIView) {
        cardContent.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        innerContent.frame = cardContent.bounds
        cardContent.addSubview(innerContent)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        // For use in Interface Builder
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 16
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.12
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 2
    }

}
