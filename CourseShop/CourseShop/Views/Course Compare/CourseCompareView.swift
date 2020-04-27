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
    @EnvironmentObject var dataModel: DataModel
    @State var modalPresented = false
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
                                SectionView(course: course, professor: course.selectedProfessor, reviewsViewable: false)
                                    .frame(height: 120)
                            }
                            .padding()
                        }
                    }
                }
                .navigationBarTitle(Text("Compare"))
            }.padding(.top, -8)
            Divider()
            Button(action: {
                self.modalPresented = true
            }) {
                Text("Add to Schedule (\(self.viewModel.selectedCourses.filter{ $0.selectedProfessor != nil }.count))")
                .foregroundColor(Color("secondary_text_color"))
            }.frame(width: 300, height: 50)
            .background(self.viewModel.selectedCourses.filter{ $0.selectedProfessor != nil }.count > 0 ? Color("theme_color") : .gray)
            .cornerRadius(25)
            .padding(.bottom, 10)
            .padding(.top, 2)
        }.sheet(isPresented: $modalPresented) {
            NavigationView {
                AddToScheduleView(selectedCourses: self.viewModel.selectedCourses, selectedSections: self.dataModel.selectedSections).environmentObject(self.dataModel)
            }
        }
    }
}

struct CourseCompareView_Previews: PreviewProvider {
    static var previews: some View {
        CourseCompareView()
    }
}

