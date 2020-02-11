//
//  CourseSelectView.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/11/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import SwiftUI

struct CourseSelectView: View {
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        VStack {
            SearchBar(searchText: $viewModel.searchStr).padding(.top)
            Group {
                if viewModel.displayedCourses.count > 0 {
                    ScrollView {
                        ForEach(viewModel.displayedCourses, id: \.self) { course in
                            CourseItemView(course: course, selected: self.viewModel.selectedCourses.contains { $0 == course })
                            .onTapGesture(perform: {
                                let i = self.viewModel.selectedCourses.firstIndex(of: course)
                                if let courseIndex = i {
                                    self.viewModel.selectedCourses.remove(at: courseIndex)
                                } else {
                                    self.viewModel.selectedCourses.append(course)
                                }
                            })
                            .shadow(radius: 5)
                            .padding()
                        }
                    }
                } else {
                    Text("No courses match your search.")
                    .foregroundColor(Color("primary_text_color"))
                }
            }
            Spacer()
            NavigationLink(destination: CourseCompareView()) {
                Text("Compare (\(self.viewModel.selectedCourses.count))")
                .foregroundColor(Color("secondary_text_color"))
            }
            .frame(width: 300, height: 50)
            .background(Color("theme_color"))
            .cornerRadius(25)
        }
        .navigationBarTitle("Course Select", displayMode: .inline)
    }
}

struct CourseSelectView_Previews: PreviewProvider {
    static var previews: some View {
        CourseSelectView()
    }
}
