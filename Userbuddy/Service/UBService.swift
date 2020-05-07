//
//  UBService.swift
//  UserBuddy
//
//  Created by Ryan Bliss on 5/3/20.
//  Copyright © 2020 UserBuddy. All rights reserved.
//

import Foundation

internal class UBService {
    let apiKey: String
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    var baseUrl: String {
        get {
            return UBEnvironment.apiBaseUrl!
        }
    }
    
    func postRequest(
        path: String,
        json: [String: Any],
        completion: @escaping (Data?, URLResponse?, Error?) -> Void
    ) {
        let session = URLSession.shared
        let url = URL(string: baseUrl + path)!
        let request = URLRequest.client(url: url, requestType: RequestType.POST, apiKey: apiKey)
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        
        let task = session.uploadTask(with: request, from: jsonData, completionHandler: completion)
        task.resume()
    }
    
}
