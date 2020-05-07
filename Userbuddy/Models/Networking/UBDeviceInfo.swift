//
//  UBDeviceInfo.swift
//  UserBuddy
//
//  Created by Ryan Bliss on 5/3/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import UIKit

struct UBDeviceInfo {
    let deviceId: String
    let OS = "iOS"
    let systemVersion: String
    let appVersion: String?
    let sdkVersion: String?
    let deviceType: String
    var ipAddress: String? = nil
    init() {
        let bundle = Bundle(for: UBSurveyView.self)
        self.deviceId = UIDevice.current.identifierForVendor!.uuidString
        self.systemVersion = UIDevice.current.systemVersion
        self.appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        self.sdkVersion = bundle.infoDictionary?["CFBundleShortVersionString"] as? String
        self.deviceType = UIDevice.current.modelName
        self.ipAddress = IPAddress.getWiFiAddress()
    }
}
