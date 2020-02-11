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
        ScrollView {
            ForEach(viewModel.selectedCourses, id: \.self) { course in
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .padding()
                        .shadow(radius: 2)

                    NavigationLink(destination: SectionCompare(course: course)) {
                        VStack {
                            CourseHeaderView(course: course)
                            SectionView(section: course.selectedSection)
                                .frame(height: 120)
                                .padding(.top, 10)
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

struct CourseCompareView_Previews: PreviewProvider {
    static var previews: some View {
        CourseCompareView()
    }
}
