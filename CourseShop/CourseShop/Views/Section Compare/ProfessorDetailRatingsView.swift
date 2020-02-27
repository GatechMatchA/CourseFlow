//
//  ProfessorDetailRatingsView.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/15/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct ProfessorDetailRatingsView: View {
    var professor: Professor
    var body: some View {
        HStack {
            //Spacer()
            VStack {
                VStack {
                    Text("Quality").bold()
                    Text("(\(Int.random(in: 1...25)))").padding(.bottom, -10).padding(.top, 3).minimumScaleFactor(0.7)
                    StarRating(maxRating: 5, rating: Binding.constant(professor.avgQuality), ratingType: .floatRatings, editable: false).frame(height: 20)
                    Text(String(format: "%.2f%/5", professor.avgQuality)).padding(.top, -10)
                    // Text("\(professor.quality.count) ratings")
                    // BarChartView(data: ChartConstants.qualityData, title: String(format: "%.2f", professor.avgQuality), form: CGSize(width: 50, height: 200), dropShadow: false)
                    Spacer()
                }.padding().background(Color.white).padding([.top], 5).minimumScaleFactor(0.9)
                VStack {
                    Text("Easiness").bold()
                    Text("\(Int.random(in: 1...25)) ratings").padding(.bottom, -10).padding(.top, 5).minimumScaleFactor(0.7)
                    StarRating(maxRating: 5, rating: Binding.constant(professor.avgEasiness), ratingType: .floatRatings, editable: false).frame(height: 20)
                    Text(String(format: "%.2f%/5", professor.avgEasiness)).padding(.top, -10)
                    // Text("\(professor.easiness.count) ratings")
                    // BarChartView(data: ChartConstants.easinessData, title: String(format: "%.2f", professor.avgEasiness), form: CGSize(width: 50, height: 200), dropShadow: false)
                    Spacer()
                }.padding().background(Color.white).padding([.top, .bottom], 5).minimumScaleFactor(0.9)
            }.frame(width: 100).padding([.leading, .trailing], 5)//.background(Color.white).padding([.top, .bottom], 5)
            //Spacer()
            VStack {
                HStack {
                    Spacer()
                    Text("GPA").bold().padding(.bottom, 32)
                    Spacer()
                }
                BarChartView(data: ChartData(values: professor.gpaChartData), title: String(format: "Avg: %.1f%", professor.avgGPA), dropShadow: false, valueSpecifier: "%.f percent")
            }.padding().background(Color.white).padding([.top, .bottom, .trailing], 5)
            //Spacer()
            /*
            VStack {
                Text("Easiness")
                StarRating(maxRating: 5, rating: professor.avgEasiness, ratingType: .floatRatings, editable: false).frame(height: 20)
                // BarChartView(data: ChartConstants.easinessData, title: String(format: "%.2f", professor.avgEasiness), form: CGSize(width: 50, height: 200), dropShadow: false)
                Spacer()
            }.frame(width: 55, height: 260).padding().background(Color.white).padding([.top, .bottom], 5)
            Spacer()
             */
        }.background(Color("item_unselected")).padding()
    }
}

struct ProfessorDetailRatingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfessorDetailRatingsView(professor: Constants.sampleProfessor)
    }
}
