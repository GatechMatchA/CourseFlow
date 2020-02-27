//
//  ProfessorDetailViewModel.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/14/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import Foundation

class ProfessorDetailViewModel: ObservableObject {
    @Published var reviews: [Review] = []
    var course: Course
    var professor: Professor
    
    init(course: Course, professor: Professor) {
        self.course = course
        self.professor = professor
    }
    
    func loadReviews() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.reviews = Constants.professorRatingsMapping["\(self.course.courseNum) \(self.professor.name)"]!
//        }
        let reviewReq = ReviewRequest()
        reviewReq.getReviews(course: self.course, professor: self.professor, onSuccess: { (reviews) in
            print(reviews)
            DispatchQueue.main.async {
                self.reviews = reviews
            }
        }) { (error) in
            print(error)
        }
    }
    func upvote(review: Review, isDownVoted: Bool) {
        let i = self.reviews.firstIndex(of: review)!
        self.reviews[i].upVotes += 1
    }
    func downvote(review: Review, isUpVoted: Bool) {
        let i = self.reviews.firstIndex(of: review)!
        self.reviews[i].downVotes += 1
    }
}
