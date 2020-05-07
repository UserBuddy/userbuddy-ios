//
//  UBLoadFile.swift
//  UserBuddy
//
//  Created by Ryan Bliss on 5/3/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import Foundation

class UBLoadFile {
    static func loadJSON(path: String) throws -> [String: Any] {
        let bundle = Bundle(for: UBLoadFile.self)
        if let path = bundle.path(forResource: path, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, Any> {
                    return jsonResult
                }
                throw "UserBuddy:: UBLoadFile: Unable to load JSON"
            } catch {
                throw "UserBuddy:: UBLoadFile: Unable to load JSON"
            }
        }
        
        throw "UserBuddy:: UBLoadFile: Unable to load JSON"
    }
}
