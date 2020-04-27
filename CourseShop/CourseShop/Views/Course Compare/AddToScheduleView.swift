//
//  AddToScheduleView.swift
//  CourseShop
//
//  Created by Rahil Patel on 4/27/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import SwiftUI

struct AddToScheduleView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dataModel: DataModel
    var selectedCourses: [Course]
    @State var selectedSections: [CourseSection]
    var body: some View {
        Form {
            ForEach(selectedCourses.filter {$0.selectedProfessor != nil}, id: \.cID) { course in
                Section(header: HStack {
                    Text("\(course.courseName)")
                    Spacer()
                    Text("\(course.selectedProfessor!.name)")
                }) {
                    ForEach(course.selectedProfessor!.sections, id:\.sID) { section in
                        Button(action: {
                            if self.selectedSections.contains (where: {$0.sID == section.sID}) {
                                self.selectedSections.removeAll {$0.sID == section.sID}
                            } else {
                                self.selectedSections.append(section)
                            }
                        }) {
                            VStack {
                                HStack {
                                    Text("Section \(section.letter)")
                                    Spacer()
                                }
                                HStack {
                                    Text("\(section.daysStr()) | \(section.startTime)-\(section.endTime)")
                                    Spacer()
                                }
                            }.padding()
                        }.background(self.selectedSections.contains {$0.sID == section.sID} ? Color("item_selected") : Color("item_unselected")).cornerRadius(5)
                    }
                }
            }
            Section(footer: HStack {
                Spacer()
                Button(action: {
                    self.dataModel.selectedSections = self.selectedSections
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Add To Schedule").foregroundColor(.white)
                }).frame(width: 250, height: 40).background(Color.blue).cornerRadius(10)
                Spacer()
                }) {
                    EmptyView()
            }
        }.navigationBarTitle("Section Select")
    }
}

struct AddToScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        AddToScheduleView(selectedCourses: [], selectedSections: [])
    }
}
