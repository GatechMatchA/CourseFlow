//
//  DataModel.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/11/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import Foundation

class DataModel: ObservableObject {
    // selected for comparison
    @Published var courses: [Course] = []
    @Published var selectedSections: [CourseSection] = []
    @Published var user: User
    @Published var loggedIn = false
    init(user: User) {
        self.user = user
    }
    
    func login(username: String, password: String) {
        UserRequest().loginUser(username: username, password: password, onSuccess: {
            self.loggedIn = true
        }) { (err) in
            print(err)
        }
    }
    func signUp(username: String, password: String) {
        UserRequest().signUpUser(username: username, password: password, onSuccess: {
            self.loggedIn = true
        }) { (err) in
            print(err)
        }
    }
}
