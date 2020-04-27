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
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.professors = Constants.testProfessors
//            onComplete()
//        }
        let profReq = ProfessorRequest()
        profReq.getProfessors(for: course, onSuccess: { (profs) in
            print(profs)
            DispatchQueue.main.async {
                self.professors = profs.sorted{$0.name < $1.name}
                onComplete()
            }
        }) { (error) in
            print(error)
        }
    }
    func sort(by param: String) {
        switch param {
        case "GPA":
            self.professors = professors.sorted { $0.avgGPA > $1.avgGPA }
        case "Quality":
            self.professors = professors.sorted { $0.avgQuality > $1.avgQuality }
        case "Easiness":
            self.professors = professors.sorted { $0.avgEasiness > $1.avgEasiness }
        default:
            _ = 0
        }
        
    }
}
