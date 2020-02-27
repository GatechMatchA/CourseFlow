//
//  StarRating.swift
//  CourseShop
//
//  Created by Rahil Patel on 2/15/20.
//  Copyright © 2020 MatchA. All rights reserved.
//

import SwiftUI

struct StarRating: UIViewRepresentable {
    var maxRating: Int
    @Binding var rating: Double
    var ratingType: FloatRatingView.FloatRatingViewType
    var editable = true
    var didUpdate: (() -> Void)?
    var isUpdating:(() -> Void)?
    var view = FloatRatingView()
    func makeUIView(context: Context) -> FloatRatingView {
        self.view.type = ratingType
        self.view.rating = rating
        self.view.maxRating = maxRating
        self.view.emptyImage = UIImage(systemName: "star")
        self.view.fullImage = UIImage(systemName: "star.fill")
        self.view.editable = editable
        return self.view
    }
    func updateUIView(_ uiView: FloatRatingView, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        var a: () -> Void = {}
        var b: () -> Void = {}
        if let didUpdate = didUpdate {
            a = didUpdate
        }
        if let isUpdating = isUpdating {
            b = isUpdating
        }
        return Coordinator(view: self.view, didUpdate: a, isUpdating: b, newRating: newRating(rating:))
    }
    private func newRating(rating: Double) {
        self.rating = rating
    }
    class Coordinator: NSObject, FloatRatingViewDelegate {
        var didUpdate: () -> Void
        var isUpdating: () -> Void
        var newRating: (Double) -> Void
        
        init(view: FloatRatingView, didUpdate: @escaping () -> Void, isUpdating: @escaping () -> Void, newRating: @escaping (Double) -> Void) {
            self.didUpdate = didUpdate
            self.isUpdating = isUpdating
            self.newRating = newRating
            super.init()
            view.delegate = self
        }
        func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
            self.didUpdate()
            self.newRating(ratingView.rating)
        }
        func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
            self.isUpdating()
        }
    }
}
