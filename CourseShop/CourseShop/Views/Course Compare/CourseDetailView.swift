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
                        HStack {
                            Spacer()
                            VStack {
                                Text("\(self.courseDetailViewModel.courseDetails.course.courseNum)").font(.largeTitle)
                                Text("\(self.courseDetailViewModel.courseDetails.course.courseName)").font(.headline).multilineTextAlignment(.center)
                                Text("\(self.courseDetailViewModel.courseDetails.course.numCredits) Credits")
                            }
                            Spacer()
                            }.padding().background(Color("item_selected"))
                        VStack {
                            Group {
                                self.leadingText(Text("Course Summary:").bold()).padding(.top, 5)
                                self.leadingText(Text("\(self.courseDetailViewModel.courseDetails.summary)"))
                                Divider()
                                self.leadingText(Text("Restrictions:").bold())
                                self.leadingText(Text("\(self.courseDetailViewModel.courseDetails.restrictions)"))
                            }
                            if self.courseDetailViewModel.courseDetails.prereqs != nil {
                                Divider()
                            }
                            self.leadingText(self.optionalTitle(variable: self.courseDetailViewModel.courseDetails.prereqs, title: "Prerequisites:").map { Text($0).bold() })
                            self.leadingText(self.courseDetailViewModel.courseDetails.prereqs.map { Text($0) })
                            if self.courseDetailViewModel.courseDetails.attributes != nil {
                                Divider()
                            }
                            self.leadingText(self.optionalTitle(variable: self.courseDetailViewModel.courseDetails.attributes, title: "Attributes:").map { Text($0).bold() })
                            self.leadingText(self.courseDetailViewModel.courseDetails.attributes.map { Text("Attributes: \($0)") })
                        }
                        Spacer()
                    }.background(Color("item_unselected"))
                }
        }.onAppear {
            self.courseDetailViewModel.loadCourseDetails(for: self.course) {
                self.isLoading = false
            }
        }.background(Color("item_selected")).edgesIgnoringSafeArea(.bottom)
    }
    
    func leadingText(_ text: Text?) -> some View {
        HStack {
            text.padding(.leading)
            Spacer()
        }
    }
    func optionalTitle(variable: Any?, title: String) -> String? {
        if let _ = variable {
            return title
        }
        return nil
    }
}

struct CourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetailView(courseDetailViewModel: CourseDetailViewModel(), course: Constants.sampleCourse)
    }
}
