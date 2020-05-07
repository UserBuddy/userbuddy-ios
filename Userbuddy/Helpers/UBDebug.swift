//
//  UBDebug.swift
//  UserBuddy
//
//  Created by Ryan Bliss on 5/3/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import Foundation

class UBDebug {
    static func log(_ printText: String) {
        let output = "Userbuddy SDK: \(printText)\n  ⮑ \(Date().toISO8601())"
        print(output)
    }
}
