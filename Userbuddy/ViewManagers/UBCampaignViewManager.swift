//
//  UBCampaignViewManager.swift
//  UserBuddy
//
//  Created by Ryan Bliss on 5/3/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import UIKit
import StoreKit

class UBCampaignManager {
    fileprivate static var isCampaignActivelyDisplayed = false;
    
    static var campaigns: [UBCampaign] = []
    
    static func register(campaigns _campaigns: [UBCampaign]) {
        campaigns = _campaigns
        maybeDisplayNext()
    }
    
    static func remove(campaign: UBCampaign) {
        isCampaignActivelyDisplayed = false
        
        let index = campaigns.firstIndex { (val) -> Bool in
            val.id == campaign.id
        }
        if let index = index {
            campaigns.remove(at: index)
            maybeDisplayNext()
        }
    }
    
    static fileprivate func maybeDisplayNext() {
        if (campaigns.count > 0) {
            let campaignToShow = campaigns.first { (campaign) -> Bool in
                return campaign.display.automatic
            }
            
            if let campaign = campaignToShow {
                displayWithDelay(using: campaign)
                return;
            }
        }
        
        UBDebug.log("no campaigns to display")
    }
    
    static func maybeDisplayCampaign(by name: String) {
        if isCampaignActivelyDisplayed {
            return
        }
        
        let campaign = campaigns.first { (val) -> Bool in
            return val.name == name
        }
        if let campaign = campaign {
            self.displayWithDelay(using: campaign)
        } else {
            UBDebug.log("campaign with name \(name) not found")
        }
    }
    
    static fileprivate func displayWithDelay(using campaign: UBCampaign) {
        isCampaignActivelyDisplayed = true
        
        var systemDelay: Double = 0
        if UIApplication.shared.windows.count == 0 {
            systemDelay = 1
        }
        let delayTime: Double = systemDelay + (Double(campaign.display.delay) / 1000)
        UBDebug.log("displaying campaign \(campaign.name) in \(delayTime) seconds")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
            UBDebug.log("now displaying campaign \(campaign.name)")
            switch campaign.type {
            case "Survey":
                displaySurvey(using: campaign)
                break;
            case "Review":
                requestReviewIfAppropriate(using: campaign)
                break
            case "Content":
                displayContent(using: campaign)
                break
            default:
                break
            }
        }
        
        return;
    }
    
    static fileprivate func displaySurvey(using campaign: UBCampaign) {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if let window = window {
            let v = UBSurveyView(frame: window.bounds, campaign: campaign)
            window.addSubview(v)
        }
    }
    
    static fileprivate func displayContent(using campaign: UBCampaign) {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if let window = window {
            let v = UBContentView(frame: window.bounds, campaign: campaign)
            window.addSubview(v)
        }
    }
    
    static fileprivate func requestReviewIfAppropriate(using campaign: UBCampaign) {
        SKStoreReviewController.requestReview()
        Userbuddy.campaigns.complete(campaign)
    }
}
