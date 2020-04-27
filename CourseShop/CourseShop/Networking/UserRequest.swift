//
//  UserRequest.swift
//  CourseShop
//
//  Created by Rahil Patel on 4/26/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import Foundation

class UserRequest: CourseShopRequest {
    func loginUser(username: String, password: String, onSuccess: @escaping () -> Void, onFail: @escaping (Error) -> Void) {
        let path = "/accounts/login"
        let data = ["username": username, "password": password]
        HttpRequest.makePostRequest(urlString: baseURL + path, authVal: nil, data: data, success: { (res) in
            onSuccess()
        }) { (err) in
            onFail(err)
        }
    }
    func signUpUser(username: String, password: String, onSuccess: @escaping () -> Void, onFail: @escaping (Error) -> Void) {
        let path = "/accounts/signup"
        let data = ["username": username, "password": password]
        HttpRequest.makePostRequest(urlString: baseURL + path, authVal: nil, data: data, success: { (res) in
            onSuccess()
        }) { (err) in
            onFail(err)
        }
    }
}
