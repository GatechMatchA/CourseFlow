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
        allCourses.filter { $0.courseName.starts(with: searchStr) || $0.courseNum.starts(with: searchStr)}
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
            sorted = valid.sorted { $0.selectedProfessor!.quality > $1.selectedProfessor!.quality }
        case "Easiness":
            sorted = valid.sorted { $0.selectedProfessor!.easiness > $1.selectedProfessor!.easiness }
        default:
            sorted = valid
        }
        self.selectedCourses = sorted + invalid
    }
}
