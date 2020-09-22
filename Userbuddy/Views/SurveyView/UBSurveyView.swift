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
    
    var response: UBLogEvent?
    var responseIndex: Int = 0
    var campaign: UBCampaign?
    
    var modalContainer: UBModalContainer?
    var activeContentView: UIView?
    
    convenience init(frame: CGRect, campaign: UBCampaign) {
        self.init(frame: frame)
        
        self.campaign = campaign
        self.response = UBLogEvent(name: "$SurveyQuestionResponse", params: [
            "campaignId": self.campaign!.id
        ])
        
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
            let currentIndex = self.responseIndex
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
//        print(introduction)
    }
    
    fileprivate func display(conclusion: UBConclusion) {
        // TODO: display conclusion, remove submit
        submit()
    }
    
    fileprivate func display(question: UBQuestion) {
        let innerContentContainer = modalContainer!.cardContainer
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
        case "MultipleChoice":
            let onPress: (String) -> Void = { (textInput) in
                self.logResponse(textInput, question: question)
            }
            let view = UIView.initialize(using: "UBMultipleChoice", frame: frame)
            if let view = view as? UBMultipleChoice {
                view.setProperties(question: question, onPress: onPress)
            }
            modalContainer?.setInnerContent(view)
            break
        default:
            break
        }
    }
    
    fileprivate func logResponse(_ questionResponse: Any, question: UBQuestion) {
        responseIndex += 1
        
        self.response!.add(property: questionResponse, withKey: question.id)
        try! self.setActiveContent()
    }
    
    fileprivate func submit() {
        Userbuddy.events.track(single: response!)
        
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
