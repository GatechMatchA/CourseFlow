//
//  ProfessorSelectViewModel.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/14/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import Foundation

class ProfessorSelectViewModel: ObservableObject {
    @Published var professors: [Professor] = []
    func loadProfessors(for course: Course, onComplete: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.professors = Constants.testProfessors
            onComplete()
        }
    }
    func sort(by param: String) {
        switch param {
        case "GPA":
            self.professors = professors.sorted { $0.avgGPA > $1.avgGPA }
        case "Quality":
            self.professors = professors.sorted { $0.quality > $1.quality }
        case "Easiness":
            self.professors = professors.sorted { $0.easiness > $1.easiness }
        default:
            _ = 0
        }
        
    }
}
