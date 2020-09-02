//
//  AddBarcodeView.swift
//  GameComparison
//
//  Created by Personal on 8/30/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct AddBarcodeView: View {
    var codeFoundCallback: ((_ code: String?) -> ())?  = nil
    var body: some View {
         ScannerViewControllerRepresentable(codeFoundCallback: { code in
            if let code = code {
                if let callback = self.codeFoundCallback {
                    callback(code)
                }
            }
         })
        .navigationBarBackButtonHidden(true)
    }
}

struct AddBarcodeView_Previews: PreviewProvider {
    static var previews: some View {
        AddBarcodeView()
    }
}
