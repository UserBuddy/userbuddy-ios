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
        track(event: event)
    }
    
    // MARK: - Functions used within the SDK, but not exposed externally
    
    func track(event: UBLogEvent) {
        send(using: event)
    }
    
    func trackUsage() {
        let event = UBLogEvent(name: "$LogUsage", params: [:])
        self.send(using: event)
    }
    
    // MARK: - Internal file functions
    
    internal func send(using event: UBLogEvent) {
        let data: [String: Any] = [
            "name": event.name,
            "timestamp": event.timestamp,
            "params": event.params
        ]
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
        service.postRequest(path: "/event", json: data, completion: onComplete)
    }
}
