//
//  UBModalContainer.swift
//  UserBuddy
//
//  Created by Ryan Bliss on 5/4/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import UIKit

class UBModalContainer: UIView {

    @IBOutlet weak var modalContent: UIView!
    
    var modalView: UBModalContainer?
    var cardContainer: UBCardContainer?
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    
    func animateOpen(_ view: UIView) {
        let top = CGAffineTransform(translationX: 0, y: -bounds.maxY)

        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
              // Add the transformation in this block
              // self.container is your view that you want to animate
              view.transform = top
        }, completion: nil)
    }
    
    // MARK: - View logic
    
    func setupView() {
        let modalOverlay = UBModalBackgroundView(frame: bounds)
        self.insertSubview(modalOverlay, at: 0)
        
        let cardFrame = CGRect(x: bounds.minX, y: bounds.maxY, width: self.modalContent.bounds.width, height: self.modalContent.bounds.height)
        let cardContainer = UIView.initialize(using: "UBCardContainer", frame: cardFrame)
        if let cardContainer = cardContainer as? UBCardContainer {
            self.modalContent.addSubview(cardContainer)
            self.cardContainer = cardContainer
        }
        
        self.animateOpen(cardContainer)
    }
    
    func setInnerContent(_ innerContent: UIView) {
        if let cardContainer = cardContainer {
            innerContent.subviews.forEach { (sv) in
                if let sv = sv as? UILabel {
                    sv.sizeToFit()
                    sv.setNeedsLayout()
                    sv.layoutIfNeeded()
                }
            }
            let targetSize = CGSize(width: innerContent.bounds.width,
                height: UIView.layoutFittingExpandedSize.height)
            let preferredContentSize = innerContent.systemLayoutSizeFitting(targetSize)
            setHeight(preferredContentSize.height)
            
            cardContainer.setInnerContent(innerContent)
        }
    }
    
    internal func setHeight(_ height: CGFloat) {
        self.contentHeight.constant = height
        self.layoutIfNeeded()
        if let cardContainer = cardContainer {
            cardContainer.bounds = self.modalContent.bounds
            cardContainer.layoutIfNeeded()
        }
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    
    // MARK: - Required random stuff
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
       // For use in Interface Builder
       super.init(coder: aDecoder)
    }

}
