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
    var crn: String
    func timeStr() -> String {
        let cal = Calendar(identifier: .gregorian)
        let df = DateFormatter()
        df.dateFormat = "HH:mm:ss"
        let startDate = df.date(from: startTime)!
        let endDate = df.date(from: endTime)!
        let startHr = cal.component(.hour, from: startDate)
        let startMin = cal.component(.minute, from: startDate)
        let endHr = cal.component(.hour, from: endDate)
        let endMin = cal.component(.minute, from: endDate)
        let startStr = "\(startHr % 12 == 0 ? "12" : "\(startHr % 12)"):\(startMin < 10 ? "0\(startMin)" : "\(startMin)") \(startHr / 12 >= 1 ? "PM" : "AM")"
        let endStr = "\(endHr % 12 == 0 ? "12" : "\(endHr % 12)"):\(endMin < 10 ? "0\(endMin)" : "\(endMin)") \(endHr / 12 >= 1 ? "PM" : "AM")"
        return "\(startStr) - \(endStr)"
    }
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
