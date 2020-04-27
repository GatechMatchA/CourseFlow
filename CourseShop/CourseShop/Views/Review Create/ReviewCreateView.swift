//
//  ReviewCreateView.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/26/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import SwiftUI

struct ReviewCreateView: View {
    @EnvironmentObject var viewModel: ReviewCreateViewModel
    @EnvironmentObject var dataModel: DataModel
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 3)
    var body: some View {
        ScrollView {
            VStack {
                ReviewComponent(title: "Professor Name", input: TextField("i.e. John Doe", text: $viewModel.profName).textFieldStyle(RoundedBorderTextFieldStyle()))//.background(GeometryGetter(rect: $kGuardian.rects[0]))
                
                ReviewComponent(title: "Course Number", input: TextField("i.e. AB 7890", text: $viewModel.courseNum).textFieldStyle(RoundedBorderTextFieldStyle()))//.background(GeometryGetter(rect: $kGuardian.rects[1]))
                
                ReviewComponent(title: "Quality", input: StarRating(maxRating: 5, rating: $viewModel.quality, ratingType: .wholeRatings, editable: true).frame(height: 30))
                
                ReviewComponent(title: "Easiness", input: StarRating(maxRating: 5, rating: $viewModel.easiness, ratingType: .wholeRatings, editable: true).frame(height: 30))
                
                ReviewComponent(title: "Other comments", input: MultilineTextField("i.e. Tough homework.", text: $viewModel.comments)//.background(GeometryGetter(rect: $kGuardian.rects[2])).offset(y: kGuardian.slide).animation(.easeInOut(duration: 0.25))
                )
                Button(action: {
                    self.viewModel.createReview(user: self.dataModel.user) { (error) in
                        print(error)
                    }
                }) {
                    Text("Submit").frame(width: 250).padding().foregroundColor(.white)
                }.background(Color("theme_color")).cornerRadius(5)
            }
        }.gesture(DragGesture().onChanged({ drag in
            if drag.startLocation.y < drag.location.y {
                UIApplication.shared.endEditing()
            }
        }))
    }
    
    init() {
        self.kGuardian.showField = 2
    }
}

struct ReviewCreateView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewCreateView().environmentObject(ReviewCreateViewModel())
    }
}


struct GeometryGetter: View {
    @Binding var rect: CGRect

    var body: some View {
        GeometryReader { geometry in
            Group { () -> AnyView in
                DispatchQueue.main.async {
                    self.rect = geometry.frame(in: .global)
                }

                return AnyView(Color.clear)
            }
        }
    }
}

final class KeyboardGuardian: ObservableObject {
    public var rects: Array<CGRect>
    public var keyboardRect: CGRect = CGRect()

    // keyboardWillShow notification may be posted repeatedly,
    // this flag makes sure we only act once per keyboard appearance
    public var keyboardIsHidden = true

    @Published var slide: CGFloat = 0

    var showField: Int = 0 {
        didSet {
            updateSlide()
        }
    }

    init(textFieldCount: Int) {
        self.rects = Array<CGRect>(repeating: CGRect(), count: textFieldCount)

        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)

    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyBoardWillShow(notification: Notification) {
        if keyboardIsHidden {
            keyboardIsHidden = false
            if let rect = notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect {
                keyboardRect = rect
                updateSlide()
            }
        }
    }

    @objc func keyBoardDidHide(notification: Notification) {
        keyboardIsHidden = true
        updateSlide()
    }

    func updateSlide() {
        if keyboardIsHidden {
            slide = 0
        } else {
            let tfRect = self.rects[self.showField]
            let diff = keyboardRect.minY - tfRect.maxY

            if diff > 0 {
                slide += diff
            } else {
                slide += min(diff, 0)
            }

        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
