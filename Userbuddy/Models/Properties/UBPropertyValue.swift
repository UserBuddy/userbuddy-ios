//
//  UBEventParamValue.swift
//  UserBuddy
//
//  Created by Ryan Bliss on 5/3/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import Foundation

struct UBPropertyValue {
    fileprivate let _value: Any
    fileprivate var _type: String? {
        get {
            if _value is String {
                return "String"
            } else if _value is Int {
                return "Number"
            } else if _value is Float {
                return "Number"
            } else if _value is Bool {
                return "Boolean"
            }
            return nil;
        }
    }
    var jsonValue: [String: Any] {
        get {
            return [
                "value": self._value,
                "dataType": self._type!
            ]
        }
    }
    init(value: Any) throws {
        if value is String {
            self._value = value
        } else if value is Int {
            self._value = value
        } else if value is Float {
            self._value = value
        } else if value is Bool {
            self._value = value
        } else {
            throw "UserBuddy custom event params can only be of type String, Int, Float, or Bool."
        }
    }
}
