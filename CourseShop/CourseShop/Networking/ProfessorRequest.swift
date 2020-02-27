//
//  ProfessorRequest.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/26/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import Foundation

class ProfessorRequest: CourseShopRequest {
    func getProfessors(for course: Course, onSuccess: @escaping ([Professor]) -> Void, onFail: @escaping (Error) -> Void){
        let path = "/courses/\(course.cID)/professors"
        HttpRequest.makeGetRequest(urlString: baseURL + path, success: { (data) in
            guard let payload = data["payload"] as? [[String: Any]] else {
                onFail(CustomError("ProfessorRequest.getProfessors): payload doesn't exist or payload is not [[String: Any]]. ->\n\(data)"))
                return
            }
            var profs: [Professor] = []
            for p in payload {
                if let courseProf = self.parseCourseProfessor(for: p, onFail: { (error) in
                    onFail(error)
                }) {
                    profs.append(courseProf)
                }
            }
            
            for (i, cp) in profs.enumerated() {
                self.getProfessorDetails(for: cp.pID, onSuccess: { (fName, lName) in
                    profs[i].name = "\(fName) \(lName)"
                    onSuccess(profs)
                }) { (error) in
                    onFail(error)
                }
            }
        }) { (error) in
            onFail(error)
        }
    }
    
    func getProfessorDetails(for id: String, onSuccess: @escaping (String, String) -> Void, onFail: @escaping (Error) -> Void) {
        let path = "/professors/\(id)"
        HttpRequest.makeGetRequest(urlString: baseURL + path, success: { (data) in
            guard let payload = data["payload"] as? [String: Any] else {
                onFail(CustomError("ProfessorRequest.getProfessors): payload doesn't exist or payload is not [[String: Any]]. ->\n\(data)"))
                return
            }
            guard let fName = payload["firstName"] as? String else {
                onFail(CustomError("ProfessorRequest.getProfessors): firstName doesn't exist or firstName is not String. ->\n\(payload)"))
                return
            }
            guard let lName = payload["lastName"] as? String else {
                onFail(CustomError("ProfessorRequest.getProfessors): lastName doesn't exist or lastName is not String. ->\n\(payload)"))
                return
            }
            onSuccess(fName, lName)
        }) { (error) in
            onFail(error)
        }
    }
    
    func parseCourseProfessor(for data: [String: Any], onFail: @escaping (Error) -> Void) -> Professor? {
        print(data)
        
        let maxVal = 5.0
        
        guard let avgGPA = data["averageGpa"] as? Double else {
            onFail(CustomError("CourseRequest.getAllCourses): averageGpa doesn't exist or isn't a Double. -> \n\(data)"))
            return nil
        }
        guard let pID = data["professor"] as? Int else {
            onFail(CustomError("CourseRequest.getAllCourses): professor doesn't exist or isn't a Int. -> \n\(data)"))
            return nil
        }
        guard let cID = data["course"] as? Int else {
            onFail(CustomError("CourseRequest.getAllCourses): course doesn't exist or isn't an Int. -> \n\(data)"))
            return nil
        }
        guard let gpas = data["gradeDistribution"] as? [String: Double] else {
            onFail(CustomError("CourseRequest.getAllCourses): gradeDistribution doesn't exist or isn't a [String: Double]]. -> \n\(data)"))
            return nil
        }
        guard let avgEasiness = data["averageEasiness"] as? Double else {
            onFail(CustomError("CourseRequest.getAllCourses): averageEasiness doesn't exist or isn't a Double. -> \n\(data)"))
            return nil
        }
        guard let avgQuality = data["averageQuality"] as? Double else {
            onFail(CustomError("CourseRequest.getAllCourses): averageQuality doesn't exist or isn't a String. -> \n\(data)"))
            return nil
        }
        return Professor(pID: "\(pID)", name: "", sections: [], gpas: gpas, avgGPA: avgGPA, avgEasiness: avgEasiness * maxVal, avgQuality: avgQuality * maxVal)
    }
    
}
