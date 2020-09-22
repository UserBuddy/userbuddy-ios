//
//  UBProperties.swift
//  UserBuddy
//
//  Created by Ryan Bliss on 5/3/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import Foundation

class UBProperties {
    fileprivate let _date: Date
    var timestamp: String {
        get {
            return _date.toISO8601()
        }
    }
    fileprivate var _params: [String: UBPropertyValue] = [:]
    var params: [String: Any] {
        get {
            return _params.mapValues { value in
                return value.jsonValue;
            }
        }
        set(newValue) {
            self._params = newValue.mapValues { value in
                let newVal = try! UBPropertyValue(value: value)
                return newVal
            }
        }
    }
    init(params _params: [String: Any]) {
        self._date = Date()
        self.params = _params
    }
    func add(property: Any, withKey key: String) {
        self._params[key] = try! UBPropertyValue(value: property)
    }
}
