//
//  CloseHeaderView.swift
//  GameComparison
//
//  Created by Personal on 7/21/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct CloseButtonView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        Button(action: ({
            AnalysticsService.shared.logButtonClick("Close", pageName: "Scanner View")
            self.presentationMode.wrappedValue.dismiss()
        })) {
            Image(systemName: "xmark.circle")
                .imageScale(.medium)
                .font(.title)
                .foregroundColor(.black)
        }
    .navigationBarBackButtonHidden(true)
    .navigationBarTitle("Scan Barcode")
    }
}

struct CloseHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CloseButtonView()
    }
}
