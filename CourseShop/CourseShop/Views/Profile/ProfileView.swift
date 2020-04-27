//
//  ProfileView.swift
//  CourseShop
//
//  Created by Rahil Patel on 4/5/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var dataModel: DataModel
    @State var displayCopyMsg = false
    @State var crn = ""
    var body: some View {
        ZStack {
            Color("item_unselected").edgesIgnoringSafeArea(.bottom)
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        ZStack {
                            Color("item_selected")
                            VStack {
                                Image("sample_profile_pic")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(50)
                                Text(dataModel.user.username).font(.largeTitle).fontWeight(.ultraLight)
                            }
                        }.edgesIgnoringSafeArea(.top).frame(height: 200)
                        VStack {
                            Text("Scheduled Courses").font(.largeTitle)
                            Divider()
                            if self.dataModel.selectedSections.count > 0 {
                                ForEach(self.dataModel.selectedSections, id: \.sID) { section in
                                    ScheduledCourseView(section: section) { crn in
                                        withAnimation {
                                            self.crn = crn
                                            self.displayCopyMsg = true
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                            self.displayCopyMsg = false
                                        }
                                    }.padding()
                                }
                            } else {
                                VStack {
                                    Text("You have not selected any courses yet.")
                                    Spacer()
                                }.padding()
                            }
                        }.padding([.leading, .trailing], 5)
                        Spacer()
                    }
                }.edgesIgnoringSafeArea(.top)
                if self.dataModel.selectedSections.count > 0 {
                    Divider()
                    Text("Total Credits: \(self.dataModel.getTotalCredits())").padding()
                }
            }
            if (displayCopyMsg) {
                Text("CRN Copied:\n\(crn)").multilineTextAlignment(.center).frame(width: 150, height: 100).background(Color.white).cornerRadius(15).shadow(radius: 5)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

struct ScheduledCourseView: View {
    var section: CourseSection
    var onCopy: (String) -> Void
    var body: some View {
        VStack {
            HStack {
                Text("\(section.course.courseNum) - \(section.course.courseName) | ")
                Spacer()
                Text("\(section.course.numCredits) Credits")
            }
            HStack {
                Text("\(section.professor)")
                Spacer()
            }
            HStack {
                Text("Section \(section.letter)")
                Spacer()
                Text("\(section.daysStr()) | \(section.timeStr())")
            }
            HStack {
                Spacer()
                Button(action: {
                    UIPasteboard.general.string = self.section.crn
                    self.onCopy(self.section.crn)
                }) {
                    Text("Copy CRN").foregroundColor(.white).padding(5).padding([.leading, .trailing], 15)
                }.background(Color("item_selected")).cornerRadius(10).shadow(radius: 2).padding(.bottom, -25).padding(.top, 5)
            }
        }.padding(10).background(Color("item_selected"))
    }
}
