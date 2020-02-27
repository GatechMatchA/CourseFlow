//
//  ProfessorDetailView.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/14/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import SwiftUI

struct ProfessorDetailView: View {
    @ObservedObject var professorDetailViewModel: ProfessorDetailViewModel
    @EnvironmentObject var dataModel: DataModel
    var body: some View {
        VStack {
            VStack {
                Text(self.professorDetailViewModel.course.courseNum).font(Font.title).bold()
            Text(self.professorDetailViewModel.course.courseName).minimumScaleFactor(0.75).multilineTextAlignment(.center)
                Divider()
                ForEach(self.professorDetailViewModel.professor.sections, id: \.self) { section in
                    HStack {
                        Spacer()
                        Text("Section \(section.letter)").bold()
                        Text("|| \(section.days) | \(section.time)")
                        Spacer()
                    }
                }
            }.padding().background(Color("item_selected"))
            VStack {
                Text(self.professorDetailViewModel.professor.name).font(Font.title).padding([.leading, .trailing, .top])
                ProfessorDetailRatingsView(professor: self.professorDetailViewModel.professor)
                HStack {
                    Text("Reviews").bold()
                    Spacer()
                }.padding([.leading, .trailing])
            }
            ScrollView {
                Divider()
                ForEach(self.professorDetailViewModel.reviews, id: \.self) { review in
                    VStack {
                        HStack {
                            Image(uiImage: review.profilePicData == nil ? UIImage(named: "default_profile_pic")! : UIImage(data: review.profilePicData!)!)
                                .resizable()
                                .frame(width: 44, height: 44)
                                .cornerRadius(30)
                                .padding([.leading, .trailing])
                            Text(review.comments)
                                .frame(height: 80)
                                .lineLimit(nil)
                                .minimumScaleFactor(0.5)
                            Spacer()
                            VStack {
                                HStack {
                                    Button(action: {
                                        if !self.dataModel.user.upvotedReviews.contains(review.rid) {
                                            self.dataModel.user.upvotedReviews.append(review.rid)
                                            let isDownVoted = self.dataModel.user.downvotedReviews.contains(review.rid)
                                            self.professorDetailViewModel.upvote(review: review, isDownVoted: isDownVoted)
                                            if isDownVoted {
                                                self.dataModel.user.downvotedReviews.removeAll { $0 == review.rid }
                                            }
                                        }
                                    }) {
                                        Image(systemName: self.upVoteImageName(review: review))
                                    }
                                    Text("\(review.upVotes)").frame(width: 40)
                                }
                                HStack {
                                    Button(action: {
                                        if !self.dataModel.user.downvotedReviews.contains(review.rid) {
                                            self.dataModel.user.downvotedReviews.append(review.rid)
                                            let isUpVoted = self.dataModel.user.upvotedReviews.contains(review.rid)
                                            self.professorDetailViewModel.downvote(review: review, isUpVoted: isUpVoted)
                                            if isUpVoted {
                                                self.dataModel.user.upvotedReviews.removeAll { $0 == review.rid }
                                            }
                                        }
                                    }) {
                                        Image(systemName: self.downVoteImageName(review: review))
                                    }
                                    Text("\(review.downVotes)").frame(width: 40)
                                }
                            }.padding([.leading, .trailing], 5)
                        }
                    }.background(Color("item_unselected"))
                }
            }
            Spacer()
        }
        .onAppear {
            self.professorDetailViewModel.loadReviews()
            
        }
    }
    func downVoteImageName(review: Review) -> String {
        return dataModel.user.downvotedReviews.contains(review.rid) ? "arrowtriangle.down.fill" : "arrowtriangle.down"
    }
    func upVoteImageName(review: Review) -> String {
        return dataModel.user.upvotedReviews.contains(review.rid) ? "arrowtriangle.up.fill" : "arrowtriangle.up"
    }
    func getNumDownSpaces(for review: Review) -> String {
        let diff = review.downVotes % 10 - review.upVotes % 10
        print("Down: \(diff)")
        var str = ""
        if diff <= 0 { return str }
        for _ in 0 ..< diff {
            str += " "
        }
        return str
    }
    func getNumUpSpaces(for review: Review) -> String {
        let diff = review.upVotes % 10 - review.downVotes % 10
        print("Up: \(diff)")
        var str = ""
        if diff <= 0 { return str }
        for _ in 0 ..< diff {
            str += " "
        }
        return str
    }
}

struct ProfessorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfessorDetailView(professorDetailViewModel: ProfessorDetailViewModel(course: Constants.sampleCourse, professor: Constants.sampleProfessor))
    }
}
