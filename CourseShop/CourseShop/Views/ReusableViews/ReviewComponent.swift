//
//  ReviewComponent.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/26/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import SwiftUI

struct ReviewComponent<Input>: View where Input: View {
    var title: String
    var input: Input
    var body: some View {
        VStack {
            HStack {
                Text(title).bold()
                Spacer()
            }
            input
        }.padding().background(Color("item_unselected"))
    }
}

struct ReviewComponent_Previews: PreviewProvider {
    static var previews: some View {
        ReviewComponent(title: "Test", input: TextField("Placeholder", text: Binding.constant("")))
    }
}
