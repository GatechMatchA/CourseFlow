//
//  CourseCompareView.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/11/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import SwiftUI

struct CourseCompareView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            FilterBar(sort: self.viewModel.sort(by:))
            Divider()
            ScrollView {
                ForEach(viewModel.selectedCourses, id: \.self) { course in
                    ZStack {
                        Rectangle()
                            .foregroundColor(.white)
                            .padding()
                            .shadow(radius: 2)

                        NavigationLink(destination: SectionCompare(course: Binding(get: {
                            course
                        }, set: { (newCourse) in
                            for (i, c) in self.viewModel.selectedCourses.enumerated() {
                                if c == newCourse {
                                    self.viewModel.selectedCourses[i] = newCourse
                                }
                            }
                        }))) {
                            VStack {
                                CourseHeaderView(course: course)
                                SectionView(professor: course.selectedProfessor, reviewsViewable: false)
                                    .frame(height: 120)
                            }
                            .padding()
                        }
                    }
                }
                .navigationBarTitle(Text("Compare"))
            }
        }
    }
}

struct CourseCompareView_Previews: PreviewProvider {
    static var previews: some View {
        CourseCompareView()
    }
}

struct FilterBar: View {
    var sort: (String) -> Void
    @State var gpaActive = false
    @State var qualityActive = false
    @State var easinessActive = false
    var body: some View {
        HStack {
            Button(action: {
                self.gpaActive.toggle()
                self.qualityActive = false
                self.easinessActive = false
                withAnimation {
                    self.sort("GPA")
                }
            }) {
                center(Text("GPA"), active: self.gpaActive)
            }
            Divider()
            Button(action: {
                self.qualityActive.toggle()
                self.gpaActive = false
                self.easinessActive = false
                withAnimation {
                    self.sort("Quality")
                }
            }) {
                center(Text("Quality"), active: self.qualityActive)
            }
            Divider()
            Button(action: {
                self.easinessActive.toggle()
                self.gpaActive = false
                self.qualityActive = false
                withAnimation {
                    self.sort("Easiness")
                }
            }) {
                center(Text("Easiness"), active: self.easinessActive)
            }
        }.frame(height: 30).padding([.top, .leading, .trailing])
    }
    
    func center(_ text: Text, active: Bool) -> some View {
        HStack {
            Spacer()
            Image(systemName: active ? "arrowtriangle.down.fill" : "arrowtriangle.down")
            text
            Spacer()
        }
    }
}
