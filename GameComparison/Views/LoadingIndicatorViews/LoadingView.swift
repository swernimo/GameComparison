//
//  LoadingView.swift
//  GameComparison
//
//  Created by Personal on 9/18/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    @Binding var loading: Bool
    var body: some View {
        ActivityIndicator(isAnimating: self.$loading, style: .medium)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(loading: .constant(true))
    }
}
