//
//  UBRequest.swift
//  UserBuddy
//
//  Created by Ryan Bliss on 5/3/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import Foundation

extension URLRequest {
    static func client(url: URL, requestType: RequestType, apiKey: String) -> URLRequest {
        let deviceInfo = UBDeviceInfo()
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "apiKey")
        request.setValue(deviceInfo.deviceId, forHTTPHeaderField: "deviceId")
        request.setValue(deviceInfo.OS, forHTTPHeaderField: "os")
        request.setValue(deviceInfo.systemVersion, forHTTPHeaderField: "osVersion")
        request.setValue(deviceInfo.appVersion, forHTTPHeaderField: "appVersion")
        request.setValue(deviceInfo.sdkVersion, forHTTPHeaderField: "sdkVersion")
        request.setValue(deviceInfo.deviceType, forHTTPHeaderField: "deviceType")
        request.setValue(deviceInfo.ipAddress, forHTTPHeaderField: "ipAddress")
        
        return request
    }
}
