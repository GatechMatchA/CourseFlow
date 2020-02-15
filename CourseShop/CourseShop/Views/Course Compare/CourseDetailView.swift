//
//  CourseDetailView.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/14/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import SwiftUI

struct CourseDetailView: View {
    @ObservedObject var courseDetailViewModel: CourseDetailViewModel
    var course: Course
    @State var isLoading = true
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Done")
                    }.padding()
                    Spacer()
                }
                LoadingView(isShowing: $isLoading) {
                    VStack {
                        VStack {
                            Text("\(self.courseDetailViewModel.courseDetails.course.courseNum)").font(.largeTitle)
                            Text("\(self.courseDetailViewModel.courseDetails.course.courseName)").font(.headline).multilineTextAlignment(.center)
                            Text("\(self.courseDetailViewModel.courseDetails.course.numCredits) Credits")
                        }
                        Spacer()
                        self.leadingText(Text("Campuses offered:").bold())
                        self.leadingText(Text("\(self.courseDetailViewModel.courseDetails.campuses)"))
                        self.leadingText(Text("Course Summary:").bold()).padding(.top, 5)
                        self.leadingText(Text("\(self.courseDetailViewModel.courseDetails.summary)"))
                        self.leadingText(self.courseDetailViewModel.courseDetails.prereqs.map { Text($0) })
                        self.leadingText(self.courseDetailViewModel.courseDetails.attributes.map { Text("Attributes: \($0)") })
                        Spacer()
                    }
                }
                Spacer()
        }.onAppear {
            self.courseDetailViewModel.loadCourseDetails(for: self.course) {
                self.isLoading = false
            }
        }
    }
    
    func leadingText(_ text: Text?) -> some View {
        HStack {
            text.padding(.leading)
            Spacer()
        }
    }
}

struct CourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetailView(courseDetailViewModel: CourseDetailViewModel(), course: Constants.sampleCourse)
    }
}
