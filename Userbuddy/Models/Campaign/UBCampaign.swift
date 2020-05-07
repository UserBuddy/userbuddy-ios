//
//  UBCampaign.swift
//  UserBuddy
//
//  Created by Ryan Bliss on 5/3/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import Foundation

// MARK: - Campaign
struct UBCampaign: Codable {
    let id, name, createdAt, editedAt: String
    let responseRequired: Bool
    let type: String
    let priority: Int
    let display: UBDisplay
    let typeData: UBCampaignTypeData
}

// MARK: - CampaignTypeData

struct UBCampaignTypeData: Codable  {
    let survey: UBSurvey?
    let content: UBContent?
}

// MARK: - Display
struct UBDisplay: Codable {
    let type: String
    let automatic: Bool
    let delay: Int
}

// MARK: - Survey
struct UBSurvey: Codable {
    let displayProgress: Bool
    let introduction: UBIntroduction?
    let questions: [UBQuestion]
    let conclusion: UBConclusion?
}

// MARK: - Content

struct UBContent: Codable {
    let type, title, subtitle, ctaText, dismissText, linkUrl: String
    let required: Bool
}

// MARK: - Conclusion
struct UBIntroduction: Codable {
    let title: String
    let subtitle: String?
    let buttonText: String?
}

// MARK: - Conclusion
struct UBConclusion: Codable {
    let title: String
    let subtitle: String?
    let duration: Int
}

// MARK: - Question
struct UBQuestion: Codable {
    let id, friendlyId, dataType, template: String
    let title: String
    let required: Bool
}

