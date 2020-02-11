//
//  SectionView.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/11/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import SwiftUI

struct SectionView: View {
    var section: Section?
    var body: some View {
        Group {
            if section != nil {
                VStack {
                    HStack {
                        Text("Section \(section!.letter) - \(section!.professor)")
                        Spacer()
                    }
                    .padding([.top, .leading, .trailing], 10)
                    Divider()
                    HStack {
                        HStack {
                            Spacer()
                            VStack {
                                Text("GPA")
                                Text(String(format: "%.2f", section!.avgGPA))
                            }
                            Spacer()
                        }
                        Divider()
                        HStack {
                            Spacer()
                            VStack {
                                Text("Quality")
                                Text(String(format: "%.2f", section!.quality))
                            }
                            Spacer()
                        }
                        Divider()
                        HStack {
                            Spacer()
                            VStack {
                                Text("Easiness")
                                Text(String(format: "%.2f", section!.easiness))
                            }
                            Spacer()
                        }
                    }
                    .padding(.bottom, 10)
                }
                .background(Color("item_unselected"))
                .foregroundColor(Color("primary_text_color"))
            } else {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("Tap to select a section")
                            .foregroundColor(Color("primary_text_color"))
                        Spacer()
                    }
                    Spacer()
                }.background(Color("item_unselected"))
            }
        }
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(section: Constants.sampleSection)
    }
}
