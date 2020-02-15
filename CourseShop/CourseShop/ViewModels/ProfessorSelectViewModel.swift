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
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.professors = Constants.testProfessors
            onComplete()
        }
    }
}
