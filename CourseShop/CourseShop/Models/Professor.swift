//
//  Professor.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/14/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import Foundation

struct Professor: Hashable {
    var pID: String = "\(UUID())"
    var name: String
    var sections: [Section]
    var avgGPA: Double
    var easiness: Double
    var quality: Double
}
