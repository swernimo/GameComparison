//
//  ScannerView.swift
//  GameComparison
//
//  Created by Personal on 7/22/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI
import Combine

struct ScannerView: View {
    var body: some View {
        ScannerViewControllerRepresentable()
            .onAppear(perform: {
                AnalysticsService.shared.logPageView("Scanner View")
            })
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
