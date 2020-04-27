//
//  CalendarEvent.swift
//  CourseShop
//
//  Created by Rahil Patel on 4/27/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import Foundation

struct CalendarEvent {
    var days: [DaysOfWeek]
    // 1.5 = 1:30 AM, 22.25 = 10:15 PM
    var start: Double
    // 1.25 = 1 hours and 15 minutes
    var duration: Double
    var text: String
    var sectionID: String
}

enum DaysOfWeek: String, CaseIterable {
    case sunday = "Sunday"
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    
}
