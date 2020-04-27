//
//  ScheduleViewModel.swift
//  CourseShop
//
//  Created by Rahil Patel on 4/27/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import Foundation
import Combine

class ScheduleViewModel: ObservableObject {
    var objectWillChange: ObservableObjectPublisher = ObservableObjectPublisher()
    @Published var selected: CalendarEvent?
    @Published var events: [CalendarEvent] = []
    
    func timeRange(for event: CalendarEvent) -> String {
        let finalTime = event.start + event.duration
        let hour = Int(event.start)
        let minute = Int((event.start - Double(hour)) * 60)
        let minuteStr = minute < 10 ? "0\(minute)" : "\(minute)"
        
        let finalHour = Int(finalTime)
        let finalMinute = Int((finalTime - Double(finalHour)) * 60)
        let finalMinuteStr = finalMinute < 10 ? "0\(finalMinute)" : "\(finalMinute)"
        return "\(hour % 12 == 0 ? 12 : hour % 12):\(minuteStr) \(hour / 12 == 0 ? "AM" : "PM") - \(finalHour % 12 == 0 ? 12 : finalHour % 12):\(finalMinuteStr) \(finalHour / 12 == 0 ? "AM" : "PM")"
    }
    
    func getEvents(for sections: [CourseSection]) {
        for section in sections {
            let tInfo = timeInfo(for: section)
            let event = CalendarEvent(days: section.days, start: tInfo.0, duration: tInfo.1, text: "\(section.course.courseNum)", sectionID: section.sID)
            events.append(event)
        }
    }
    private func timeInfo(for section: CourseSection) -> (Double, Double) {
        let df = DateFormatter()
        df.dateFormat = "HH:mm:ss"
        let start = df.date(from: section.startTime)!
        let end = df.date(from: section.endTime)!
        let cal = Calendar(identifier: .gregorian)
        let startHr = cal.component(.hour, from: start)
        let startMin = cal.component(.minute, from: start)
        let endHr = cal.component(.hour, from: end)
        let endMin = cal.component(.minute, from: end)
        
        let startSum: Double = Double(startHr) + Double(startMin)/60
        let endSum: Double = Double(endHr) + Double(endMin)/60
        
        return (startSum, startSum - endSum)
    }
    
    init(sections: [CourseSection]) {
        self.getEvents(for: sections)
    }
}
