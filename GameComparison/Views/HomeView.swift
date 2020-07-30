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
    @State var collection: [CollectionItem] = []
    
    var body: some View {
        VStack {
            NavigationView {
                List{
                    ForEach(collection) { item in
                        ListItem(collectionItem: item)
                    }
                }
                    .navigationBarTitle("My Game Library", displayMode: .inline)
                .navigationBarItems(trailing:
                    NavigationLink(destination: ScannerView()){
                        Image(systemName: "barcode.viewfinder")
                            .imageScale(.small)
                            .font(.title)
                })
            }
        }.onAppear(perform: {
            API.getCollection(username: "swernimo"){
                x in
                self.collection = x
            }
        })
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(collection: [])
    }
}
