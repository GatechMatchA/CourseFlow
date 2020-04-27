//
//  ReviewCreateViewModel.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/26/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import Foundation

class ReviewCreateViewModel: ObservableObject {
    @Published var profName: String = ""
    @Published var courseNum: String = ""
    @Published var quality: Double = 0.0
    @Published var easiness: Double = 0.0
    @Published var comments: String = ""
    
    func createReview(user: User, fail: @escaping (String) -> Void) {
        if quality < 1 {
            fail("Quality must be greater than or equal to one star.")
        } else {
            let reviewReq = ReviewRequest()
            let profReq = ProfessorRequest()
            let courseReq = CourseRequest()
            
            //TODO: Get course and prof ID from profName and courseNum
            
            let data: [String: Any] = [
                "professor": 2,
                "course": 1,
                "quality": quality,
                "easiness": easiness == 0 ? -1 : easiness,
                "comments": comments
            ]
            reviewReq.createReview(user: user, data: data, onSuccess: {
                print("Success!")
            }) { (error) in
                print(error)
            }
        }
    }
}
