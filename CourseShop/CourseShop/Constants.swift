//
//  Constants.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/11/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import Foundation

struct Constants {
    static var testCourses = [
        Course(courseNum: "CS 1331", courseName: "Introduction to Object Oriented Programming", numCredits: 3),
        Course(courseNum: "CS 1332", courseName: "Data Structures and Algorithms", numCredits: 3),
        Course(courseNum: "CS 2050", courseName: "Introduction to Discrete Math", numCredits: 3),
        Course(courseNum: "CS 3451", courseName: "Computer Graphics", numCredits: 3)
    ]
    
    static var testProfessors = [
        Professor(name: "Christopher Simpkins", sections: [Constants.testSectionA, Constants.testSectionB], avgGPA: 3.02, easiness: 4.5, quality: 4.9),
        Professor(name: "Monica Sweat", sections: [Constants.testSectionC, Constants.testSectionD], avgGPA: 2.73, easiness: 4.1, quality: 3.2),
        Professor(name: "Susan Watson-Phillips", sections: [Constants.testSectionC], avgGPA: 2.91, easiness: 3.2, quality: 2.0),
        Professor(name: "John Stasko", sections: [Constants.testSectionD], avgGPA: 2.66, easiness: 2.1, quality: 4.6)
    ]
    
    static var testSectionA = Section(letter: "A", days: "MWF", time: "10:30 - 11:20")
    static var testSectionB = Section(letter: "B", days: "MWF", time: "1:30 - 2:20")
    static var testSectionC = Section(letter: "C", days: "TR", time: "1:30 - 2:20")
    static var testSectionD = Section(letter: "D", days: "TR", time: "2:00 - 2:50")
    
    static var sampleCourse = Course(courseNum: "CS 1331", courseName: "Introduction to Object Oriented Programming", numCredits: 3)
    static var placeholderCourse = Course(courseNum: "AA 0000", courseName: "Loading Course Name", numCredits: 0)
    
    static var sampleProfessor = Professor(name: "Christopher Simpkins", sections: [Constants.testSectionA], avgGPA: 3.02, easiness: 4.5, quality: 4.9)
    
    static var courseSectionMapping = [
        "CS 1331": Constants.testProfessors,
        "CS 1332": Constants.testProfessors,
        "CS 3451": Constants.testProfessors,
        "CS 2050": Constants.testProfessors
    ]
    
    static var sampleCourseDetails = CourseDetails(course: Constants.sampleCourse, summary: Constants.sampleCourseDescription, campuses: "Georgia Tech-Atlanta * Campus")
    static var placeholderCourseDetails = CourseDetails(course: Constants.placeholderCourse, summary: "Loading course summary.", campuses: "Loading course campus offerings.")
    
    static var sampleCourseDescription = "Introduction to techniques and methods of object-oriented programming such an encapsulation, inheritance, and polymorphism. Emphasis on software development and individual programming skills."
}
