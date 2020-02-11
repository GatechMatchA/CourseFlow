//
//  CourseHeaderView.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/11/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import SwiftUI

struct CourseHeaderView: View {
    var course: Course
    @State var infoPresented = false
    var body: some View {
        VStack {
            HStack {
                Text(course.courseNum)
                    .padding(.leading)
                Text("\(course.numCredits) Credits")
                    .padding([.leading, .trailing])
                Spacer()
                
                Button(action: {
                    self.infoPresented = true
                }) {
                    Image(systemName: "info.circle.fill")
                    .font(Font.custom("Aventir", size: 20))
                }
            }
            HStack {
                Text(course.courseName)
                    .lineLimit(1)
                Spacer()
            }
            .padding([.leading, .trailing])
        }
        .padding(10)
        .background(Color("item_selected"))
        .foregroundColor(Color("primary_text_color"))
        .font(Font.custom("Aventir", size: 12))
        .sheet(isPresented: $infoPresented, onDismiss: nil) {
            Text("Course info for \(self.course.courseNum): \(self.course.courseName)")
        }
    }
}

struct CourseHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CourseHeaderView(course: Constants.sampleCourse)
    }
}
