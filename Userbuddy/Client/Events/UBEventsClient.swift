//
//  UBEvents.swift
//  Userbuddy
//
//  Created by Ryan Bliss on 5/6/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import Foundation

public class UBEventsClient: UBClient {
        
    // MARK: - Public functions exposed through the SDK
    
    public func track(named name: String, properties: [String:Any]) {
        let event = UBLogEvent(name: name, params: properties)
        track(single: event)
    }
    
    // MARK: - Functions used within the SDK, but not exposed externally
    
    func trackUsage() {
        let event = UBLogEvent(name: "$Usage", params: [:])
        self.track(single: event)
    }
    
    func track(single event: UBLogEvent) {
        send(single: event)
    }
    
    func track(many events: [UBLogEvent]) {
        send(many: events)
    }
    
    // MARK: - Internal file functions
    
    internal func send(single event: UBLogEvent) {
        let data: [String: Any] = event.toJSON()
        
        let onComplete: (Data?, URLResponse?, Error?) -> Void = { data, response, error in
            if let response = response as? HTTPURLResponse {
                if (response.statusCode == 200) {
                    UBDebug.log("event " + event.name + " tracked successfully")
                } else {
                    if let error = error {
                        UBDebug.log("event \(event.name) failed to log with status code \(response.statusCode): \(error.localizedDescription)")
                    } else {
                        UBDebug.log("event " + event.name + " failed to log. An unknown error occured.")
                    }
                }
            }
        }
        service.postRequest(path: "/events/single", json: data, completion: onComplete)
    }
    
    internal func send(many events: [UBLogEvent]) {
        let data: [String: Any] = [
            "list": events.map({ (event) -> ([String : Any]) in
                return event.toJSON()
            })
        ]
        
        let onComplete: (Data?, URLResponse?, Error?) -> Void = { data, response, error in
            if let response = response as? HTTPURLResponse {
                if (response.statusCode == 200) {
                    UBDebug.log("\(events.count) events tracked successfully")
                } else {
                    if let error = error {
                        UBDebug.log("\(events.count) events failed to log with status code \(response.statusCode): \(error.localizedDescription)")
                    } else {
                        UBDebug.log("\(events.count) events failed to log. An unknown error occured.")
                    }
                }
            }
        }
        service.postRequest(path: "/events/many", json: data, completion: onComplete)
    }
}
