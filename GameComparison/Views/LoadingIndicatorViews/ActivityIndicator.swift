//
//  ActivityIndicator.swift
//  GameComparison
//
//  Created by Personal on 9/18/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
// source: https://stackoverflow.com/questions/56496638/activity-indicator-in-swiftui

import Foundation
import UIKit
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
