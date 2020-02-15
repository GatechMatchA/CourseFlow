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
            SortBar(sort: self.viewModel.sort(by:)).foregroundColor(Color("primary_text_color"))
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

