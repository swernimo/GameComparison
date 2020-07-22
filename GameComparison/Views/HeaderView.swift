//
//  Header.swift
//  GameComparison
//
//  Created by Personal on 7/20/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI
import CoreImage
import UIKit

struct HeaderView: View {
    var body: some View {
        NavigationView {
            Text("My Library")
            .hidden()
                .navigationBarTitle("Game Comparsion", displayMode: .inline)
            .navigationBarItems(trailing:
                NavigationLink(destination: ScannerView()){
                    Image(systemName: "barcode.viewfinder")
                        .imageScale(.small)
                        .font(.title)
            })
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
