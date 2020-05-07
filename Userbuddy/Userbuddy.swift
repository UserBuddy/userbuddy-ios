//
//  UserBuddy.swift
//  UserBuddy
//
//  Created by Ryan Bliss on 5/2/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import UIKit

public class Userbuddy {
    
    let service: UBService
    fileprivate let eventsClient: UBEventsClient
    fileprivate let personClient: UBPersonClient
    fileprivate let campaignsClient: UBCampaignsClient
    init(service _service: UBService) {
        self.service = _service
        self.eventsClient = UBEventsClient()
        self.personClient = UBPersonClient()
        self.campaignsClient = UBCampaignsClient()
    }
    
    public static var instance: Userbuddy?
    public static var events: UBEventsClient {
        get {
            return try! getEventClient()
        }
    }
    public static var person: UBPersonClient {
        get {
            return try! getPersonClient()
        }
    }
    public static var campaigns: UBCampaignsClient {
        get {
            return try! getCampaignsClient()
        }
    }
    
    // MARK: - Public functions exposed through the SDK
    
    public static func initialize(apiKey: String) {
        UBDebug.log("Initializing")
        
        let service = UBService(apiKey: apiKey)
        
        instance = Userbuddy(service: service)
        
        events.trackUsage()
        campaigns.getEligble()
    }
    
    // MARK: - Functions used within the SDK, but not exposed externally
    
    
    // MARK: - Functions used internally within this file
    
    fileprivate static func getEventClient() throws -> UBEventsClient {
        if let instance = instance {
            return instance.eventsClient
        } else {
            throw "getEventClient: SDK has not been initialized"
        }
    }
    
    fileprivate static func getPersonClient() throws -> UBPersonClient {
        if let instance = instance {
            return instance.personClient
        } else {
            throw "getPersonClient: SDK has not been initialized"
        }
    }
    
    fileprivate static func getCampaignsClient() throws -> UBCampaignsClient {
        if let instance = instance {
            return instance.campaignsClient
        } else {
            throw "getCampaignsClient: SDK has not been initialized"
        }
    }
}
