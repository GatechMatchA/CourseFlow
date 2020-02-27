//
//  HttpRequest.swift
//  MusificationSwiftUI
//
//  Created by Rahil Patel on 6/15/19.
//  Copyright © 2019 Rahil. All rights reserved.
//

import Foundation

class HttpRequest {
    static func makeGetRequest(urlString: String, success: @escaping (_ data: [String:Any]) -> Void, fail: @escaping (_ error: Error) -> Void) {
        if let dbURL = URL(string: urlString) {
            var dbRequest = URLRequest(url: dbURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
            dbRequest.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: dbRequest) { (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                        if let data = json as? [String:Any] {
                            success(data)
                        } else {
                            fail(CustomError("JSON data from HTTP request was not an dictionary of [String:Any]"))
                        }
                    } catch {
                        fail(error)
                    }
                } else {
                    fail(CustomError("Data from HTTP request is null."))
                }
            }
            task.resume()
        } else {
            fail(CustomError("Bad URL string"))
        }
    }
    
    static func makePostRequest(urlString: String, authVal: String, data: [String: Any], success: @escaping (_ data: [String: Any]) -> Void, fail: @escaping (_ error: Error) -> Void) {
        guard let dbURL = URL(string: urlString) else {
            fail(CustomError("HttpRequest.makePostRequest: Invalid URL"))
            return
        }
        var dbRequest = URLRequest(url: dbURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        
        dbRequest.httpMethod = "POST"
        dbRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        dbRequest.addValue(authVal, forHTTPHeaderField: "Authorization")
        do {
            dbRequest.httpBody = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            let task = URLSession.shared.dataTask(with: dbRequest) { (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                        if let data = json as? [String:Any] {
                            success(data)
                        } else {
                            fail(CustomError("JSON data from HTTP request was not an dictionary of [String:Any]"))
                        }
                    } catch {
                        fail(error)
                    }
                } else {
                    fail(CustomError("Data from HTTP request is null."))
                }
            }
            task.resume()
        } catch {
            fail(error)
        }
    }
}

struct CustomError : LocalizedError {
    var errorDescription: String? { return mMsg }
    var failureReason: String? { return mMsg }
    var recoverySuggestion: String? { return "" }
    var helpAnchor: String? { return "" }
    
    private var mMsg : String
    
    init(_ description: String)
    {
        mMsg = description
    }
}
