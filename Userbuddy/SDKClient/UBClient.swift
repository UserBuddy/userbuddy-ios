//
//  UBClient.swift
//  Userbuddy
//
//  Created by Ryan Bliss on 5/6/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import Foundation

public class UBClient {
    var service: UBService {
        get {
            return Userbuddy.instance!.service
        }
    }
}
