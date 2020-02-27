//
//  Review.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/14/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import Foundation

struct Review: Hashable {
    var rid: String
    var uid: String
    var cid: String
    var profilePicData: Data?
    var comments: String
    var upVotes: Int
    var downVotes: Int
    var tags: [String]
    var quality: Double?
    var easiness: Double?
}
