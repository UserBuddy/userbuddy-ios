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
    fileprivate let lightTheme: UBTheme
    fileprivate let darkTheme: UBTheme?
    init(service: UBService, lightTheme: UBTheme, darkTheme: UBTheme?) {
        self.service = service
        self.eventsClient = UBEventsClient()
        self.personClient = UBPersonClient()
        self.campaignsClient = UBCampaignsClient()
        self.lightTheme = lightTheme
        self.darkTheme = darkTheme
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
    static var theme: UBTheme {
        get {
            let _instance = try! getInstance()
            switch UBDeviceTheme.current {
            case .light:
                return _instance.lightTheme
            case .dark:
                if let darkTheme = _instance.darkTheme {
                    return darkTheme
                }
                return _instance.lightTheme
            }
        }
    }
    
    // MARK: - Public functions exposed through the SDK
    
    public static func initialize(apiKey: String, lightTheme: UBTheme = UBTheme.standard, darkTheme: UBTheme? = nil) {
        UBDebug.log("Initializing")
        
        let service = UBService(apiKey: apiKey)
        
        instance = Userbuddy(service: service, lightTheme: lightTheme, darkTheme: darkTheme)
        
        events.trackUsage()
        campaigns.getEligble()
    }
    
    // MARK: - Functions used within the SDK, but not exposed externally
    
    
    // MARK: - Functions used internally within this file
    
    fileprivate static func getInstance() throws -> Userbuddy {
        if let instance = instance {
            return instance
        } else {
            throw "getInstance: SDK has not been initialized"
        }
    }
    
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
