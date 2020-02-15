//
//  SortBar.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/14/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import SwiftUI

struct SortBar: View {
    var sort: (String) -> Void
    @State var gpaActive = false
    @State var qualityActive = false
    @State var easinessActive = false
    var body: some View {
        HStack {
            Button(action: {
                self.gpaActive.toggle()
                self.qualityActive = false
                self.easinessActive = false
                withAnimation {
                    self.sort("GPA")
                }
            }) {
                center(Text("GPA"), active: self.gpaActive)
            }
            Divider()
            Button(action: {
                self.qualityActive.toggle()
                self.gpaActive = false
                self.easinessActive = false
                withAnimation {
                    self.sort("Quality")
                }
            }) {
                center(Text("Quality"), active: self.qualityActive)
            }
            Divider()
            Button(action: {
                self.easinessActive.toggle()
                self.gpaActive = false
                self.qualityActive = false
                withAnimation {
                    self.sort("Easiness")
                }
            }) {
                center(Text("Easiness"), active: self.easinessActive)
            }
        }.frame(height: 30).padding([.top, .leading, .trailing])
    }
    
    func center(_ text: Text, active: Bool) -> some View {
        HStack {
            Spacer()
            Image(systemName: active ? "arrowtriangle.down.fill" : "arrowtriangle.down")
            text
            Spacer()
        }
    }
}
