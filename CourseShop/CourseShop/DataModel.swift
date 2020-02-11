//
//  DataModel.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/11/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import Foundation

class DataModel: ObservableObject {
    @Published var courses: [Course] = []
}
