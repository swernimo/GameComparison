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

struct HomeView: View {
    var body: some View {
        VStack {
            NavigationView {
                List{
                    Text("Item 1")
                    Text("Item 2")
                }
                    .navigationBarTitle("My Game Library", displayMode: .inline)
                .navigationBarItems(trailing:
                    NavigationLink(destination: ScannerView()){
                        Image(systemName: "barcode.viewfinder")
                            .imageScale(.small)
                            .font(.title)
                })
            }
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
