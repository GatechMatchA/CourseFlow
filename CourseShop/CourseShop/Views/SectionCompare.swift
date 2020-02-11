//
//  SectionCompare.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/11/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import SwiftUI

struct SectionCompare: View {
    var course: Course
    var body: some View {
        Text("Comparing section for \(course.courseNum): \(course.courseName)")
    }
}

struct SectionCompare_Previews: PreviewProvider {
    static var previews: some View {
        SectionCompare(course: Constants.sampleCourse)
    }
}
