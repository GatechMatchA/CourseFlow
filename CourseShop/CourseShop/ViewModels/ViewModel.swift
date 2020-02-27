//
//  ViewModel.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/11/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var selectedCourses: [Course] = []
    @Published var allCourses: [Course] = []
    @Published var searchStr = ""
    var displayedCourses: [Course] {
        allCourses.filter { searchStr == "" || $0.courseName.capitalized.contains(searchStr.capitalized) || $0.courseNum.capitalized.contains(searchStr.capitalized)}
    }
    @Published var modalPresented = false
    
    func sort(by param: String) {
        let valid = selectedCourses.filter { $0.selectedProfessor != nil }
        let invalid = selectedCourses.filter { $0.selectedProfessor == nil }
        var sorted: [Course] = []
        switch param {
        case "GPA":
            sorted = valid.sorted { $0.selectedProfessor!.avgGPA > $1.selectedProfessor!.avgGPA }
        case "Quality":
            sorted = valid.sorted { $0.selectedProfessor!.avgQuality > $1.selectedProfessor!.avgQuality }
        case "Easiness":
            sorted = valid.sorted { $0.selectedProfessor!.avgEasiness > $1.selectedProfessor!.avgEasiness }
        default:
            sorted = valid
        }
        self.selectedCourses = sorted + invalid
    }
    
    func loadCourses(onSuccess: @escaping () -> Void, onFail: @escaping (String) -> Void) {
        let courseReq = CourseRequest()
        courseReq.getAllCourses(onSuccess: { (courses) in
            print(courses)
            DispatchQueue.main.async {
                self.allCourses = courses
            }
        }) { (error) in
            print(error)
        }
    }
}
