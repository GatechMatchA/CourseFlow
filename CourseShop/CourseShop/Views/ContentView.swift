//
//  ContentView.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/10/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var searchStr = ""
    @EnvironmentObject var dataModel: DataModel
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var reviewCreateViewModel: ReviewCreateViewModel
    @State var isPresented = false
    var body: some View {
        Group {
            if dataModel.loggedIn {
                TabView {
                    NavigationView {
                        CourseSelectView()
                        .environmentObject(viewModel)
                        .environmentObject(dataModel)
                    }
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Compare")
                    }.tag(0)
                    NavigationView {
                        ScheduleView()
                        .environmentObject(dataModel)
                            .environmentObject(ScheduleViewModel(sections: dataModel.selectedSections))
                        .navigationBarTitle("Schedule", displayMode: .inline)
                        .navigationBarHidden(true)
                    }.tabItem {
                        Image(systemName: "calendar")
                        Text("Schedule")
                    }.tag(1)
                    NavigationView {
                        ReviewCreateView()
                        .environmentObject(reviewCreateViewModel)
                        .environmentObject(dataModel)
                        .navigationBarTitle("Review", displayMode: .inline)
                    }
                    .tabItem {
                        Image(systemName: "plus.circle")
                        Text("Review")
                    }.tag(2)
                    ProfileView()
                    .environmentObject(dataModel)
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }.tag(3)
                }.sheet(isPresented: $viewModel.modalPresented) {
                    Text("Make a review")
                }.edgesIgnoringSafeArea([])
            } else {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
