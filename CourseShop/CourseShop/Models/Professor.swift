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
    var sections: [CourseSection]
    var gpas: [String:Double]
    var avgGPA: Double
    var avgEasiness: Double
    var avgQuality: Double
    
    var gpaChartData: [(String, Double)] {
        gpas.enumerated().map({($1.key.capitalized, $1.value * 100)}).sorted(by: { $0.0 < $1.0 })
    }
}
