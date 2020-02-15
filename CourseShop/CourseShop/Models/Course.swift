//
//  Course.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/11/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import Foundation

struct Course: Hashable {
    var cID: String = "\(UUID())"
    var courseNum: String
    var courseName: String
    var numCredits: Int
    var selectedProfessor: Professor?
    
    static func == (lhs: Course, rhs: Course) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(courseNum)
        hasher.combine(courseName)
        hasher.combine(numCredits)
    }
}
