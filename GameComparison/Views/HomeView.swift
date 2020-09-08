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
    @EnvironmentObject var library: Library
    @State private var showMenu = false
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                VStack{
                    NavigationView {
                        List{
                            ForEach(self.library.library, id: \.id) { item in
                                NavigationLink(destination: ListDetail(game: item)) {
                                    ListItem(game: item)
                                        .frame(height: geo.size.height * 0.1)
                                }
                            }
                        }
                        .navigationBarTitle("My Game Library", displayMode: .inline)
                        .navigationBarItems(trailing:
                            NavigationLink(destination: ScannerView()){
                                Image(systemName: "barcode.viewfinder")
                                    .imageScale(.small)
                                    .font(.title)
                        })
                        .navigationBarItems(leading: Button(action: {
                            self.showMenu.toggle()
                        }){
                          Image(systemName: "line.horizontal.3")
                            .imageScale(.small)
                            .font(.title)
                        })
                    }
                    if (self.showMenu) {
                        MenuView()
//                        MenuView(showMenu: self.$showMenu)
                            .frame(width: (geo.size.width * 0.5), height: geo.size.height, alignment: .leading)
                            .transition(.move(edge: .leading))
                    }
                }
            }.onAppear(perform: {
                API(self.library).getGameLibrary(username: "swernimo")
            })
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        .environmentObject(Library())
    }
}
