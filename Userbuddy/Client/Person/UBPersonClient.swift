//
//  UBPersonClient.swift
//  Userbuddy
//
//  Created by Ryan Bliss on 5/6/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import Foundation

public class UBPersonClient: UBClient {
    
    // MARK: - Public functions exposed through the SDK
    
    public func set(properties: [String:Any]) {
        let _properties = UBProperties(params: properties)
        set(properties: _properties)
    }
    
    // MARK: - Functions used within the SDK, but not exposed externally
    
    func set(properties: UBProperties) {
        send(using: properties)
    }
    
    // MARK: - Internal file functions
    
    internal func send(using properties: UBProperties) {
        let data: [String: Any] = [
            "timestamp": properties.timestamp,
            "properties": properties.params
        ]
        let onComplete: (Data?, URLResponse?, Error?) -> Void = { data, response, error in
            if let response = response as? HTTPURLResponse {
                if (response.statusCode == 200) {
                    UBDebug.log("person properties successfully set")
                } else {
                    if let error = error {
                        UBDebug.log("person properties failed to set with status code \(response.statusCode): \(error.localizedDescription)")
                    } else {
                        UBDebug.log("person properties failed to set. An unknown error occured.")
                    }
                }
            }
        }
        service.postRequest(path: "/person/properties", json: data, completion: onComplete)
    }
    
}
