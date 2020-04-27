//
//  Calendar.swift
//  CourseShop
//
//  Created by Rahil Patel on 4/27/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var viewModel: ScheduleViewModel
    var rowHeight: CGFloat
    var rowWidth: CGFloat
    let timeColWidth: CGFloat = 40
    @State var minY: CGFloat = 0
    var body: some View {
                ScrollView {
                    HStack {
                        VStack(alignment: .trailing) {
                            ForEach(0..<24, id: \.self) { hour in
                                Group {
                                    Text("\(hour % 12 == 0 ? 12 : hour % 12):00\n").font(.footnote) + Text("\(hour / 12 == 0 ? "AM" : "PM")").font(.caption)
                                }.frame(width: self.timeColWidth, height: self.rowHeight).multilineTextAlignment(.trailing)
                            }
                        }.padding(.leading, 5).padding(.top, -35)
                        Divider()
                        ScrollView([.horizontal], showsIndicators: true) {
                            
                            HStack {
                                ForEach(DaysOfWeek.allCases, id: \.self) { day in
                                    HStack {
                                        CalendarRow(day: day.rawValue, rowHeight: self.rowHeight, rowWidth: self.rowWidth, events: self.viewModel.events.filter { $0.days.contains(day) }).padding(.top, -8).frame(width: self.rowWidth)
                                        Divider()
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(rowHeight: 10, rowWidth: 100)
    }
}

struct CalendarRow: View {
    @EnvironmentObject var viewModel: ScheduleViewModel
    var day: String
    var rowHeight: CGFloat
    var rowWidth: CGFloat
    var events: [CalendarEvent]
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(self.events, id: \.text) { event in
                    self.render(event: event, for: geometry)
                }
                VStack {
                    Text(self.day).bold().frame(height: 40).padding(.top, 62).offset(x: 0, y: self.getOffsetForHeaderImage(geometry)).zIndex(2)
                    Divider()
                    ForEach(0..<24, id: \.self) { hour in
                        VStack {
                            Text(" ").frame(height: self.rowHeight - 21)
                            Divider()
                        }
                    }
                }
            }
        }
    }
    
    private func render(event: CalendarEvent, for geo: GeometryProxy) -> some View {
        let diff: CGFloat = CGFloat(event.start) - 11
        return VStack {
            Button(action: {
                print("Event tapped")
                withAnimation {
                    self.viewModel.selected = event
                    self.viewModel.objectWillChange.send()
                }
            }) {
                Text("\(event.text)\n\(viewModel.timeRange(for: event))")
            }.padding(.top, 5)
            Spacer()
        }.frame(width: rowWidth, height: rowHeight * CGFloat(event.duration)).background(Color("item_selected")).cornerRadius(10).shadow(radius: viewModel.selected?.sectionID == event.sectionID ? 5 : 0).offset(x: 0, y: diff * rowHeight - 8)
    }
    
    private func eventOccuring(hour: Int) -> Bool {
        self.events.contains {$0.start <= Double(hour) && $0.start + $0.duration > Double(hour)}
    }
    private func eventAt(hour: Int) -> CalendarEvent {
        return self.events.first {$0.start <= Double(hour) && $0.start + $0.duration > Double(hour)}!
    }
    private func getScrollOffset(_ geometry: GeometryProxy) -> CGFloat {
        let min = geometry.frame(in: .global).minY
        return min
    }
    
    // 2
    private func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        
        // Image was pulled down
        if offset < 36 {
            return 36-offset
        }
        
        return 36 - offset
    }
}
