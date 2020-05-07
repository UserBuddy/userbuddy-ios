//
//  UBSurveyView.swift
//  UserBuddy
//
//  Created by Ryan Bliss on 5/2/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import UIKit

public class UBSurveyView: UIView {
    
    var introShown = false
    var conclusionShown = false
    
    var responses: [UBLogEvent] = []
    var campaign: UBCampaign?
    
    var modalContainer: UBModalContainer?
    var activeContentView: UIView?
    
    convenience init(frame: CGRect, campaign: UBCampaign) {
        self.init(frame: frame)
        
        self.campaign = campaign
        
        switch campaign.display.type {
        case "Popup":
            if campaign.display.type == "Popup" {
                self.modalContainer = UBModalContainer(frame: frame, innerContent: self.activeContentView)
                self.addSubview(self.modalContainer!)
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
            let currentIndex = responses.count
            if let survey = campaign.typeData.survey {
                if let intro = survey.introduction, !introShown {
                    display(introduction: intro)
                    return
                }
                
                if currentIndex >= survey.questions.count && !conclusionShown {
                    if let conclusion = survey.conclusion {
                        display(conclusion: conclusion)
                    } else {
                        submit()
                    }
                    return
                }
                
                let question = survey.questions[currentIndex]
                display(question: question)
                
                return;
            }
        }
        
        throw "Userbuddy UBSurveyView:: setActiveContent: Invalid campaign data"
    }
    
    fileprivate func display(introduction: UBIntroduction) {
        // TODO: display introduction
        print(introduction)
    }
    
    fileprivate func display(conclusion: UBConclusion) {
        // TODO: display conclusion, remove submit
        submit()
    }
    
    fileprivate func display(question: UBQuestion) {
        let innerContentContainer = modalContainer!.cardContainer!.cardContainer
        let frame = innerContentContainer!.bounds
        switch question.template {
        case "ThumbRating":
            let onPress: (Bool) -> Void = { (isThumbUp) in
                self.logResponse(isThumbUp, question: question)
            }
            let view = UIView.initialize(using: "UBThumbRating", frame: frame)
            if let view = view as? UBThumbRating {
                view.setProperties(question: question, onPress: onPress)
            }
            modalContainer?.setInnerContent(view)
            break
        case "TextInput":
            let onPress: (String) -> Void = { (textInput) in
                self.logResponse(textInput, question: question)
            }
            let view = UIView.initialize(using: "UBTextInput", frame: frame)
            if let view = view as? UBTextInput {
                view.setProperties(question: question, onPress: onPress)
            }
            modalContainer?.setInnerContent(view)
            break
        default:
            break
        }
    }
    
    fileprivate func logResponse(_ questionResponse: Any, question: UBQuestion) {
        let response = UBLogEvent(name: "$SurveyQuestionResponse", params: [
            "$campaignId": self.campaign!.id,
            "$questionId": question.id,
            "$responseValue": questionResponse
        ])
        self.responses.append(response)
        try! self.setActiveContent()
    }
    
    fileprivate func submit() {
        responses.forEach { (event) in
            Userbuddy.events.track(event: event)
        }
        
        Userbuddy.campaigns.complete(campaign!)
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
