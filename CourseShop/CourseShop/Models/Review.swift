//
//  Review.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/14/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import Foundation

struct Review: Hashable {
    var uid: String
    var profilePicData: Data
    var details: String
    var upVotes: Int
    var downVotes: Int
    var tags: [String]
}
