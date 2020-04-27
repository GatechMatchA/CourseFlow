//
//  ProfileView.swift
//  CourseShop
//
//  Created by Rahil Patel on 4/5/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    var user: User
    var body: some View {
        ZStack {
            Color("item_unselected").edgesIgnoringSafeArea(.bottom)
            VStack {
                ZStack {
                    Color("item_selected")
                    VStack {
                        Image("sample_profile_pic")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(50)
                        Text(user.username).font(.largeTitle).fontWeight(.ultraLight)
                    }
                }.edgesIgnoringSafeArea(.top).frame(height: 200)
                Spacer()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: Constants.sampleUser)
    }
}
