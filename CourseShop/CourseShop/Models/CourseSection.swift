//
//  Section.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/11/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import Foundation

struct CourseSection: Hashable {
    var sID: String = "\(UUID())"
    var letter: String
    var days: [DaysOfWeek]
    var startTime: String
    var endTime: String
    var professor: String
    var course: Course
    
    func daysStr() -> String {
        days.map{abbr(day: $0)}.reduce("", { a, b in
            "\(a)\(b)"
        })
    }
    private func abbr(day: DaysOfWeek) -> String {
        switch day {
        case .sunday:
            return "Su"
        case .monday:
            return "M"
        case .tuesday:
            return "Tu"
        case .wednesday:
            return "W"
        case .thursday:
            return "Th"
        case .friday:
            return "F"
        case .saturday:
            return "Sa"
        default:
            return "Su"
        }
    }
}
