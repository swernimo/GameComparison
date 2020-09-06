//
//  AddBarcodeView.swift
//  GameComparison
//
//  Created by Personal on 8/30/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct AddBarcodeView: View {
    @State var completeCallback: (() -> ())?  = nil
    @State private var showAlert: Bool = false;
    @State var gameId: Int32
    @State var name: String
    @State private var barcode = ""
    
    var body: some View {
         ScannerViewControllerRepresentable(codeFoundCallback: { code in
            if let code = code {
                self.barcode = code
                self.showAlert = true
            }
         })
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Add Barcode"), message: Text("Is \(self.barcode) for \(self.name)"), primaryButton: .default(Text("Yes"), action: {
                API.addBarcode(gameId: self.gameId, barcode: self.barcode, completion: { _ in
                })
                self.showAlert = false
                if let callback = self.completeCallback {
                    callback()
                }
            }), secondaryButton: .cancel(Text("No"), action: {
                self.showAlert = false
                if let callback = self.completeCallback {
                    callback()
                }
            })
        )})
    }
}

struct AddBarcodeView_Previews: PreviewProvider {
    static var previews: some View {
        AddBarcodeView(gameId: -1, name: "Name")
    }
}
