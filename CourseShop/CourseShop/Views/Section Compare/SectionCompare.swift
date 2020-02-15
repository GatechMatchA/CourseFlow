//
//  SectionCompare.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/11/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import SwiftUI

struct SectionCompare: View {
    @Binding var course: Course
    @ObservedObject var professorSelectViewModel = ProfessorSelectViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var isLoading = true
    var body: some View {
        LoadingView(isShowing: $isLoading) {
            VStack {
                SortBar(sort: self.professorSelectViewModel.sort(by:)).foregroundColor(Color("primary_text_color"))
                ScrollView {
                    ForEach(self.professorSelectViewModel.professors, id: \.self) { professor in
                        ZStack {
                            Rectangle().shadow(radius: 2)
                            Button(action: {
                                self.course.selectedProfessor = professor
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                SectionView(professor: professor, reviewsViewable: true)
                            }
                        }
                            .padding([.leading, .trailing], 10)
                            .padding([.top, .bottom], 5)
                    }
                    Divider()
                    Spacer()
                }
            }
        }.onAppear {
            self.professorSelectViewModel.loadProfessors(for: self.course) {
                self.isLoading = false
            }
            print(self.professorSelectViewModel.professors)
        }
    }
}

struct SectionCompare_Previews: PreviewProvider {
    static var previews: some View {
        SectionCompare(course: Binding.constant(Constants.sampleCourse), professorSelectViewModel: ProfessorSelectViewModel())
    }
}
