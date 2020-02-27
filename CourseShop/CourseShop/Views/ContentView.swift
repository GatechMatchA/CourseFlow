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
        TabView {
            NavigationView {
                CourseSelectView()
                .environmentObject(viewModel)
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Compare")
            }.tag(0)
            NavigationView {
                ReviewCreateView()
                .environmentObject(reviewCreateViewModel)
                    .navigationBarTitle("Review", displayMode: .inline)
            }
            .tabItem {
                Image(systemName: "plus.circle")
                Text("Review")
            }.tag(1)
            Text("Profile")
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
        }.sheet(isPresented: $viewModel.modalPresented) {
            Text("Make a review")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
