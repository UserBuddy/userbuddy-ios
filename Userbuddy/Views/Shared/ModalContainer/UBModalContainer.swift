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
    
    convenience init(frame: CGRect, innerContent: UIView?) {
        // For use in code
        self.init(frame: frame)
        
        let modalOverlay = UBModalBackgroundView(frame: frame)
        self.addSubview(modalOverlay)
        
        let bundle = Bundle(for: UBModalContainer.self)
        let nib = UINib(nibName: "UBModalContainer", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = CGRect(x: bounds.minX, y: bounds.maxY, width: bounds.width, height: bounds.height)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        if let view = view as? UBModalContainer {
            let cardContainer = UBCardContainer(frame: view.modalContent.bounds, innerContent: innerContent)
            view.modalContent.addSubview(cardContainer)
            
            self.modalView = view
            self.cardContainer = cardContainer
        }
    
        self.addSubview(view)
        self.animateOpen(view)
    }
    
    func animateOpen(_ view: UIView) {
        let top = CGAffineTransform(translationX: 0, y: -bounds.maxY)

        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
              // Add the transformation in this block
              // self.container is your view that you want to animate
              view.transform = top
        }, completion: nil)
    }
    
    // MARK: - Gross autosize logic
    
    // This function resizes the contraint and ensures all relevant views
    // also resize. It is a really gross workaround due to me not really
    // understanding how to make views initialize with their nib files
    // automatically.
    // TODO: make this less gross
    internal func setHeight(_ height: CGFloat) {
        if let modalView = modalView {
            modalView.contentHeight.constant = height
            modalView.layoutIfNeeded()
            cardContainer?.bounds = modalView.modalContent.bounds
            if let cardContainer = cardContainer {
                cardContainer.cardContainer?.bounds = modalView.modalContent.bounds
                cardContainer.cardContainer?.layoutIfNeeded()
            }
            cardContainer?.layoutIfNeeded()
            
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    // This function sets the inner content in the card container
    // To make everything autosize correctly, it also calculates the
    // preferred size of innerContent and calls setHeight.
    // TODO: make this less gross
    func setInnerContent(_ innerContent: UIView) {
        if let cardContainer = cardContainer {
            
            innerContent.subviews.forEach { (subview) in
                subview.subviews.forEach { (sv) in
                    if let sv = sv as? UILabel {
                        sv.sizeToFit()
                        sv.setNeedsLayout()
                        sv.layoutIfNeeded()
                    }
                }
                let targetSize = CGSize(width: subview.bounds.width,
                    height: UIView.layoutFittingExpandedSize.height)
                let preferredContentSize = subview.systemLayoutSizeFitting(targetSize)
                setHeight(preferredContentSize.height)
            }
            
            cardContainer.setInnerContent(innerContent)
        }
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
