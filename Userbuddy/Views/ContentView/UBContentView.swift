//
//  UBContentView.swift
//  Userbuddy
//
//  Created by Ryan Bliss on 5/6/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import UIKit

class UBContentView: UIView {
    
    var campaign: UBCampaign?
    
    var modalContainer: UBModalContainer?
    var activeContentView: UIView?
    
    convenience init(frame: CGRect, campaign: UBCampaign) {
        self.init(frame: frame)
        
        self.campaign = campaign
        
        switch campaign.display.type {
        case "Popup":
            if campaign.display.type == "Popup" {
                let modalContainer = UIView.initialize(using: "UBModalContainer", frame: frame)
                if let modalContainer = modalContainer as? UBModalContainer {
                    self.modalContainer = modalContainer
                    modalContainer.setupView()
                }
                self.addSubview(modalContainer)
            }
            break
        default:
            // TODO: handle other cases
            UBDebug.log("Display type of \(campaign.display.type) is not supported")
            break
        }
        
        try! self.setActiveContent()
    }
    
    fileprivate func setActiveContent() throws {
        if let campaign = campaign {
            if let content = campaign.typeData.content {
                switch content.type {
                case "Link":
                    addLinkContentView(content: content)
                    break
                default:
                    break
                }
            }
            return;
        }
        
        throw "Userbuddy UBContentView:: setActiveContent: Invalid campaign data"
    }
    
    fileprivate func addLinkContentView(content: UBContent) {
        let view = UIView.initialize(using: "UBContentLinkView", frame: bounds)
        if let view = view as? UBContentLinkView {
            let onPressCTA: () -> Void = { () in
                if let link = URL(string: content.linkUrl) {
                    UIApplication.shared.open(link, completionHandler: { (_) in
                        self.submit()
                    })
                }
            }
            let onPressDismiss: () -> Void = { () in
                self.dismiss()
            }
            view.setProperties(content: content, pressCTA: onPressCTA, pressDismiss: onPressDismiss)
        }
        modalContainer?.setInnerContent(view)
    }
    
    fileprivate func submit() {
        Userbuddy.campaigns.complete(campaign!)
        self.removeFromSuperview()
    }
    fileprivate func dismiss() {
        Userbuddy.campaigns.dismiss(campaign!)
        self.removeFromSuperview()
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
