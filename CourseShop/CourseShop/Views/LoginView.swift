//
//  LoginView.swift
//  CourseShop
//
//  Created by Rahil Patel on 4/26/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var dataModel: DataModel
    @State var username = ""
    @State var password = ""
    let bg = LinearGradient(gradient: Gradient(colors: [Color("item_selected"), .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Text("Login").font(.largeTitle)
                    Spacer()
                }
                Text("Username")
                TextField("i.e. JohnDoe24", text: $username).textFieldStyle(RoundedBorderTextFieldStyle())
                Text("Password")
                SecureField("5 or more characters", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
                HStack {
                    Spacer()
                    Button(action: self.login) {
                        Text("Login").foregroundColor(.white)
                    }
                        .frame(width: 200, height: 40)
                        .background(Color.blue)
                    .cornerRadius(10)
                    Spacer()
                }
            }.padding(.top, 30)
            Divider()
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Text("Register").font(.largeTitle)
                    Spacer()
                }
                Text("Username")
                TextField("i.e. JohnDoe24", text: $username).textFieldStyle(RoundedBorderTextFieldStyle())
                Text("Password")
                SecureField("5 or more characters", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
                HStack {
                    Spacer()
                    Button(action: self.login) {
                        Text("Register").foregroundColor(.white)
                    }
                        .frame(width: 200, height: 40)
                        .background(Color.blue)
                    .cornerRadius(10)
                    Spacer()
                }
            }
            Spacer()
        }.padding().background(bg).edgesIgnoringSafeArea([.top, .bottom])
    }
    func login() {
        dataModel.loggedIn = true
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
