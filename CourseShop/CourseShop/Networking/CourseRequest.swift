//
//  CourseRequest.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/26/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import Foundation

class CourseRequest: CourseShopRequest {
    
    func getAllCourses(onSuccess: @escaping ([Course]) -> Void, onFail: @escaping (Error) -> Void) {
        let path = "/courses?orderBy=code"
        HttpRequest.makeGetRequest(urlString: baseURL + path, success: { (data) in
            guard let payload = data["payload"] as? [[String: Any]] else {
                onFail(CustomError("CourseRequest.getAllCourses): payload doesn't exist or payload is not [[String: Any]]. ->\n\(data)"))
                return
            }
            var courses: [Course] = []
            for course in payload {
                if let c = self.parseCourse(for: course, onFail: { (error) in
                    onFail(error)
                }) {
                    courses.append(c)
                }
            }
            onSuccess(courses)
        }) { (error) in
            onFail(error)
        }
    }
    
    func getCourseData(for course: Course, onSuccess: @escaping (CourseDetails) -> Void, onFail: @escaping (Error) -> Void) {
        let path = "/courses/\(course.cID)"
        HttpRequest.makeGetRequest(urlString: baseURL + path, success: { (data) in
            print(data)
            guard let payload = data["payload"] as? [String: Any] else {
                onFail(CustomError("CourseRequest.getCourseData): payload doesn't exist or payload is not [[String: Any]]. ->\n\(data)"))
                return
            }
            if let details = self.parseCourseDetails(for: payload, with: course, onFail: { (error) in
                onFail(CustomError("CourseRequest.getCourseData): payload doesn't exist or payload is not [[String: Any]]. ->\n\(payload)"))
            }) {
                onSuccess(details)
            }
            
        }) { (error) in
            onFail(error)
        }
    }
    
    func parseCourse(for data: [String: Any], onFail: @escaping (Error) -> Void) -> Course? {
        guard let code = data["code"] as? String else {
            onFail(CustomError("CourseRequest.getAllCourses): code doesn't exist or isn't a String. -> \n\(data)"))
            return nil
        }
        guard let credits = data["creditHour"] as? Int else {
            onFail(CustomError("CourseRequest.getAllCourses): code doesn't exist or isn't a Int. -> \n\(data)"))
            return nil
        }
        guard let id = data["id"] as? Int else {
            onFail(CustomError("CourseRequest.getAllCourses): id doesn't exist or isn't an Int. -> \n\(data)"))
            return nil
        }
        guard let title = data["title"] as? String else {
            onFail(CustomError("CourseRequest.getAllCourses): code doesn't exist or isn't a String. -> \n\(data)"))
            return nil
        }
        return Course(cID: "\(id)", courseNum: code, courseName: title, numCredits: credits, selectedProfessor: nil)
    }
    
    func parseCourseDetails(for data: [String: Any], with course: Course, onFail: @escaping (Error) -> Void) -> CourseDetails? {
//        guard let course = parseCourse(for: data, onFail: { (error) in
//            onFail(error)
//        }) else { return nil }
        
        guard let summary = data["description"] as? String else {
            onFail(CustomError("CourseRequest.getAllCourses): code doesn't exist or isn't a String. -> \n\(data)"))
            return nil
        }
        guard let restrictions = data["restrictions"] as? String else {
            onFail(CustomError("CourseRequest.getAllCourses): code doesn't exist or isn't a Int. -> \n\(data)"))
            return nil
        }
        let prereqs = data["prerequisites"] as? String
        let attributes = data["attributes"] as? String
        return CourseDetails(course: course, summary: summary, prereqs: prereqs, attributes: attributes, restrictions: restrictions)
    }
}
