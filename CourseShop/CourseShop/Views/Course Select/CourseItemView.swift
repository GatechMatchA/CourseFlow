//
//  CourseItemView.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/11/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import SwiftUI

struct CourseItemView: View {
    var course: Course
    var selected: Bool
    var body: some View {
        VStack {
            HStack {
                Text(course.courseNum)
                    .padding(.leading)
                    
                Spacer()
                Text("\(course.numCredits) Credits")
                    .padding(.trailing)
            }
            HStack {
                Text(course.courseName)
                    .lineLimit(1)
                    .padding([.leading, .trailing, .top])
                Spacer()
            }
        }
        .padding()
        .background(selected ? Color("item_selected") : Color("item_unselected"))
        .foregroundColor(Color("primary_text_color"))
        .font(Font.custom("Aventir", size: 12))
    }
}

struct CourseItemView_Previews: PreviewProvider {
    static var previews: some View {
        CourseItemView(course: Constants.sampleCourse, selected: false)
    }
}
