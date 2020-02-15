//
//  Section.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/11/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import Foundation

struct Section: Hashable {
    var sID: String = "\(UUID())"
    var letter: String
    var days: String
    var time: String
}
