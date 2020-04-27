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
                }) { (error) in
                    onFail(error)
                }
            }
            for (i, _) in profs.enumerated() {
                self.getProfessorSections(for: course, professor: profs[i], onSuccess: { (sections) in
                    profs[i].sections = sections
                    onSuccess(profs)
                }) { (error) in
                    onFail(error)
                }
            }
        }) { (error) in
            onFail(error)
        }
    }
    
    func getProfessorSections(for course: Course, professor: Professor, onSuccess: @escaping ([CourseSection]) -> Void, onFail: @escaping (Error) -> Void) {
        let path = "/sections?course=\(course.cID)&professor=\(professor.pID)"
        HttpRequest.makeGetRequest(urlString: baseURL + path, success: { (data) in
            guard let payload = data["payload"] as? [[String: Any]] else {
                onFail(CustomError("ProfessorRequest.getProfessors): payload doesn't exist or payload is not [[String: Any]]. ->\n\(data)"))
                return
            }
            var sections: [CourseSection] = []
            for p in payload {
                let mt = p["meetingTimes"] as! [[String: Any]]
                let days = mt.map {self.getDayOfWeek(from: $0["dayOfWeek"] as! Int)}
                print(p)
                let section = CourseSection(sID: "\(p["id"] as! Int)", letter: p["sectionCode"] as! String, days: days, startTime: mt[0]["startTime"] as! String, endTime: mt[0]["endTime"] as! String, professor: professor.name, course: course, crn: p["crn"] as! String)
                sections.append(section)
            }
            onSuccess(sections)
        }) { (error) in
            onFail(error)
        }
    }
    
    func getDayOfWeek(from: Int) -> DaysOfWeek {
        switch from {
        case 0:
            return .saturday
        case 1:
            return .sunday
        case 2:
            return .monday
        case 3:
            return .tuesday
        case 4:
            return .wednesday
        case 5:
            return .thursday
        case 6:
            return .friday
        default:
            return .sunday
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
