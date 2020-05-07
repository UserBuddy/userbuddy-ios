//
//  UBEvent.swift
//  UserBuddy
//
//  Created by Ryan Bliss on 5/3/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import Foundation

class UBLogEvent: UBProperties {
    let name: String
    
    init(name _name: String, params _params: [String: Any]) {
        self.name = _name
        super.init(params: _params)
    }
}
