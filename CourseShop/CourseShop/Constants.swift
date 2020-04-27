//
//  Constants.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/11/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import Foundation
import SwiftUICharts

struct Constants {
    static var testCourses = [
        Course(courseNum: "CS 1331", courseName: "Introduction to Object Oriented Programming", numCredits: 3),
        Course(courseNum: "CS 1332", courseName: "Data Structures and Algorithms", numCredits: 3),
        Course(courseNum: "CS 2050", courseName: "Introduction to Discrete Math", numCredits: 3),
        Course(courseNum: "CS 3451", courseName: "Computer Graphics", numCredits: 3)
    ]
    
    static var testProfessors = [
        Professor(name: "Christopher Simpkins", sections: [Constants.testSectionA, Constants.testSectionB], gpas: ["a": 0.32, "b": 0.38, "c": 0.1, "d": 0.05, "f": 0.04, "w": 0.01], avgGPA: 0.3, avgEasiness: 4, avgQuality: 3),
        Professor(name: "Monica Sweat", sections: [Constants.testSectionC, Constants.testSectionD], gpas: ["a": 0.32, "b": 0.38, "c": 0.1, "d": 0.05, "f": 0.04, "w": 0.01], avgGPA: 0.3, avgEasiness: 4, avgQuality: 3),
        Professor(name: "Susan Watson-Phillips", sections: [Constants.testSectionC], gpas: ["a": 0.32, "b": 0.38, "c": 0.1, "d": 0.05, "f": 0.04, "w": 0.01], avgGPA: 0.28, avgEasiness: 4, avgQuality: 3),
        Professor(name: "John Stasko", sections: [Constants.testSectionD], gpas: ["a": 0.32, "b": 0.38, "c": 0.1, "d": 0.05, "f": 0.04, "w": 0.01], avgGPA: 0.28, avgEasiness: 4, avgQuality: 3)
    ]
    
    static var testSectionA = CourseSection(sID: "1", letter: "A", days: [.monday, .wednesday, .friday], startTime: "10:30:00", endTime: "11:20:00", professor: "Christopher Simpkins", course: Constants.sampleCourse)
    static var testSectionB = CourseSection(sID: "2", letter: "B", days: [.monday, .wednesday, .friday], startTime: "01:30:00", endTime: "02:20:00", professor: "Christopher Simpkins", course: Constants.sampleCourse)
    static var testSectionC = CourseSection(sID: "3", letter: "C", days: [.tuesday, .thursday], startTime: "01:30:00", endTime: "02:20:00", professor: "Christopher Simpkins", course: Constants.sampleCourse)
    static var testSectionD = CourseSection(sID: "4", letter: "D", days: [.tuesday, .thursday], startTime: "02:00:00", endTime: "02:50:00", professor: "Christopher Simpkins", course: Constants.sampleCourse)
    
    static var testSections = [Constants.testSectionA, Constants.testSectionB, Constants.testSectionC, Constants.testSectionD]
    
    static var sampleUser = User(username: "sarah.t", uid: "\(UUID())", upvotedReviews: [], downvotedReviews: [], reviews: [], password: "password")
    
    static var sampleCourse = Course(courseNum: "CS 1331", courseName: "Introduction to Object Oriented Programming", numCredits: 3)
    static var placeholderCourse = Course(courseNum: "AA 0000", courseName: "Loading Course Name", numCredits: 0)
    
    static var sampleProfessor = Professor(name: "Christopher Simpkins", sections: [Constants.testSectionA, Constants.testSectionB], gpas: ["a": 0.32, "b": 0.38, "c": 0.1, "d": 0.05, "f": 0.04, "w": 0.01], avgGPA: 0.3, avgEasiness: 4, avgQuality: 3)
    
    static var sampleCourseDetails = CourseDetails(course: Constants.sampleCourse, summary: Constants.sampleCourseDescription, restrictions: "Georgia Tech-Atlanta * Campus")
    static var placeholderCourseDetails = CourseDetails(course: Constants.placeholderCourse, summary: "Loading course summary.", restrictions: "Loading course campus offerings.")
    
    static var sampleCourseDescription = "Introduction to techniques and methods of object-oriented programming such an encapsulation, inheritance, and polymorphism. Emphasis on software development and individual programming skills."
    
    static var sampleReview1 = Review(rid: "\(UUID())", uid: "\(UUID())", cid: "\(UUID())", comments: "I love this professor. You can tell that the professor loves the subject.", upVotes: 10, downVotes: 2, tags: ["Amazing Lectures", "Helpful Professor"])
    static var sampleReview2 = Review(rid: "\(UUID())", uid: "\(UUID())", cid: "\(UUID())", comments: "I hate this professor. Way too much work and the professor talks too fast.", upVotes: 3, downVotes: 4, tags: ["Too Much Homework", "Tough Exams", "Required Attendence"])
    static var sampleReview3 = Review(rid: "\(UUID())", uid: "\(UUID())", cid: "\(UUID())", comments: "Meh", upVotes: 1, downVotes: 8, tags: [])
    
    static var sampleReviews = [
        Constants.sampleReview1,
        Constants.sampleReview2,
        Constants.sampleReview3
    ]
    
    static var courseSectionMapping = [
        "CS 1331": Constants.testProfessors,
        "CS 1332": Constants.testProfessors,
        "CS 3451": Constants.testProfessors,
        "CS 2050": Constants.testProfessors
    ]
    
    static var professorRatingsMapping = [
        "CS 1331 Christopher Simpkins": [Constants.sampleReview1, Constants.sampleReview2],
        "CS 1331 Monica Sweat": [Constants.sampleReview2, Constants.sampleReview3],
        "CS 1331 Susan Watson-Phillips": [],
        "CS 1331 John Stasko": []
    ]
    
    static var calendarEvents = [
        CalendarEvent(days: [.tuesday, .thursday], start: 11.5, duration: 1, text: "CS 1331", sectionID: "1"),
        CalendarEvent(days: [.monday, .wednesday], start: 8.5, duration: 1.25, text: "CS 2050", sectionID: "2"),
        CalendarEvent(days: [.tuesday, .thursday], start: 14, duration: 1.25, text: "CS 1332", sectionID: "3")
    ]
}

struct ChartConstants {
    static let gpaData = ChartData(values: [("Fall '16", Double.random(in: 1...5)), ("Spring '17", Double.random(in: 1...5)), ("Fall '17", Double.random(in: 1...5)), ("Spring '18", Double.random(in: 1...5)), ("Fall '18", Double.random(in: 1...5)), ("Spring '19", Double.random(in: 1...5)), ("Fall '19", Double.random(in: 1...5))])
    static let qualityData = ChartData(values: [("Fall '16", Double.random(in: 1...5)), ("Spring '17", Double.random(in: 1...5)), ("Fall '17", Double.random(in: 1...5)), ("Spring '18", Double.random(in: 1...5)), ("Fall '18", Double.random(in: 1...5)), ("Spring '19", Double.random(in: 1...5)), ("Fall '19", Double.random(in: 1...5))])
    static let easinessData = ChartData(values: [("Fall '16", Double.random(in: 1...5)), ("Spring '17", Double.random(in: 1...5)), ("Fall '17", Double.random(in: 1...5)), ("Spring '18", Double.random(in: 1...5)), ("Fall '18", Double.random(in: 1...5)), ("Spring '19", Double.random(in: 1...5)), ("Fall '19", Double.random(in: 1...5))])
}
