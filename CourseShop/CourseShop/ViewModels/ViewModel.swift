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
}
