//
//  UBCampaignsClient.swift
//  Userbuddy
//
//  Created by Ryan Bliss on 5/6/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import Foundation

public class UBCampaignsClient: UBClient {
    
    // MARK: - Public functions exposed through the SDK

    public func displayIfEligible(named name: String) {
        UBCampaignManager.maybeDisplayCampaign(by: name)
    }
    
    // MARK: - Functions used within the SDK, but not exposed externally
    
    func complete(_ campaign: UBCampaign) {
        let cpEvent = UBLogEvent(
            name: "$CampaignParticipation", params: [
                "$campaignId": campaign.id,
                "$didParticipate": true
            ]
        )
        Userbuddy.events.track(single: cpEvent)
        UBCampaignManager.remove(campaign: campaign)
    }
    
    func dismiss(_ campaign: UBCampaign) {
        let cpEvent = UBLogEvent(
            name: "$CampaignParticipation", params: [
                "$campaignId": campaign.id,
                "$didParticipate": false
            ]
        )
        Userbuddy.events.track(single: cpEvent)
        UBCampaignManager.remove(campaign: campaign)
    }
    
    func getEligble() {
        let surveyJson = try! UBLoadFile.loadJSON(path: "survey-campaign")
        let reviewJson = try! UBLoadFile.loadJSON(path: "review-campaign")
        let contentJson = try! UBLoadFile.loadJSON(path: "content-campaign")
        let decoder = JSONDecoder()
        let surveyJsonData = try! JSONSerialization.data(withJSONObject: surveyJson, options: [])
        let reviewJsonData = try! JSONSerialization.data(withJSONObject: reviewJson, options: [])
        let contentJsonData = try! JSONSerialization.data(withJSONObject: contentJson, options: [])
        let survey = try! decoder.decode(UBCampaign.self, from: surveyJsonData)
        let review = try! decoder.decode(UBCampaign.self, from: reviewJsonData)
        let content = try! decoder.decode(UBCampaign.self, from: contentJsonData)
        let eligibleCampaigns = [survey, review, content]
        UBCampaignManager.register(campaigns: eligibleCampaigns)
    }
    
    // MARK: - Internal file functions
}
