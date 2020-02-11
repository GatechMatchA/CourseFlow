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
    var body: some View {
        CourseSelectView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
