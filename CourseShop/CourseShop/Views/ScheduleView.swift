//
//  ScheduleView.swift
//  CourseShop
//
//  Created by Rahil Patel on 4/26/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import SwiftUI

struct ScheduleView: View {
    @EnvironmentObject var viewModel: ScheduleViewModel
    @EnvironmentObject var dataModel: DataModel
    var body: some View {
        VStack {
            CalendarView(rowHeight: 150, rowWidth: 100)
            test()
            self.renderDetails()
        }
    }
    func test() -> EmptyView {
        print("Rerendering. \(viewModel.selected)")
        return EmptyView()
    }
    func renderDetails() -> some View {
        print("rendering details")
        let section = dataModel.selectedSections.first {$0.sID == viewModel.selected?.sectionID}
        let course = section?.course
        print(section)
        print(course)
        return Group {
            if section != nil && course != nil {
                VStack {
                    HStack {
                        Text("\(course!.courseNum) - \(section!.letter)").bold()
                        Spacer()
                        Button(action: {
                            self.dataModel.selectedSections.removeAll{$0.sID == section!.sID}
                            self.viewModel.events.removeAll{$0.sectionID == section!.sID}
                        }) {
                            Image(systemName: "trash")
                        }
                    }
                    HStack {
                        Text("\(course!.courseName)")
                        Spacer()
                    }
                    HStack {
                        Text("\(section!.professor)")
                        Spacer()
                        Text("\(viewModel.timeRange(for: viewModel.selected!))")
                    }
                }.padding().background(RoundedCorners(color: Color("item_unselected"), tl: 30, tr: 30, bl: 0, br: 0)).shadow(radius: 5)
            }
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
