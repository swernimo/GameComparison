//
//  ScannerView.swift
//  GameComparison
//
//  Created by Personal on 7/22/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct ScannerView: View {
    var body: some View {
        ScannerViewControllerRepresentable()
        .overlay(CloseButtonView()
            .offset(x: -5, y: 10)
            .colorInvert(), alignment: .topTrailing)
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
