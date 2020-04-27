//
//  ReviewRequest.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/26/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import Foundation

class ReviewRequest: CourseShopRequest {
    func createReview(user: User, data: [String: Any], onSuccess: @escaping () -> Void, onFail: @escaping (Error) -> Void) {
        let path = "/reviews/new"
        guard let creds = "\(user.username):\(user.password)".data(using: .utf8)?.base64EncodedString() else {
            onFail(CustomError("Credentials failed to be encoded"))
            return
        }
        
        
        HttpRequest.makePostRequest(urlString: baseURL + path, authVal: "Basic \(creds)", data: data, success: { (res) in
            print(res)
        }) { (error) in
            print(error)
        }
        
    }
    
    func getReviews(course: Course, professor: Professor, onSuccess: @escaping ([Review]) -> Void, onFail: @escaping (Error) -> Void) {
        let path = "/reviews?course=\(course.cID)&professor=\(professor.pID)"
        HttpRequest.makeGetRequest(urlString: baseURL + path, success: { (data) in
            print(data)
            guard let payload = data["payload"] as? [[String: Any]] else {
                onFail(CustomError("ReviewRequest.getReviews): payload doesn't exist or payload is not [[String: Any]]. ->\n\(data)"))
                return
            }
            var reviews: [Review] = []
            for review in payload {
                if let r = self.parseReview(for: review, onFail: { (error) in
                    onFail(error)
                }) {
                    reviews.append(r)
                }
            }
            onSuccess(reviews)
        }) { (error) in
            onFail(error)
        }
    }
    
    func parseReview(for data: [String: Any], onFail: @escaping (Error) -> Void) -> Review? {
        guard let rid = data["id"] as? Int else {
            onFail(CustomError("CourseRequest.getAllCourses): averageGpa doesn't exist or isn't a Double. -> \n\(data)"))
            return nil
        }
        guard let uid = data["author"] as? Int else {
            onFail(CustomError("CourseRequest.getAllCourses): professor doesn't exist or isn't a Int. -> \n\(data)"))
            return nil
        }
        guard let cid = data["course"] as? Int else {
            onFail(CustomError("CourseRequest.getAllCourses): averageEasiness doesn't exist or isn't a Double. -> \n\(data)"))
            return nil
        }
        guard let comments = data["comment"] as? String else {
            onFail(CustomError("CourseRequest.getAllCourses): course doesn't exist or isn't an Int. -> \n\(data)"))
            return nil
        }
        guard let upVotes = data["upvote"] as? Int else {
            onFail(CustomError("CourseRequest.getAllCourses): gradeDistribution doesn't exist or isn't a [String: Double]]. -> \n\(data)"))
            return nil
        }
        guard let downVotes = data["downvote"] as? Int else {
            onFail(CustomError("CourseRequest.getAllCourses): averageEasiness doesn't exist or isn't a Double. -> \n\(data)"))
            return nil
        }
        return Review(rid: "\(rid)", uid: "\(uid)", cid: "\(cid)", profilePicData: nil, comments: comments, upVotes: upVotes, downVotes: downVotes, tags: [])
    }
}
