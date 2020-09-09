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
                ZStack{
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
                        .navigationBarItems(leading: HamburgerButtonView(showMenu: self.$showMenu), trailing: NavigationLink(destination: ScannerView()){
                                Image(systemName: "barcode.viewfinder")
                                    .imageScale(.small)
                                    .font(.title)
                        })
                    }
                    .frame(width: geo.size.width)
                    .offset(x: self.showMenu ? geo.size.width * 0.5 : 0)
                    .disabled(self.showMenu)
                    if (self.showMenu) {
                        MenuView(showMenu: self.$showMenu)
                            .frame(width: (geo.size.width * 0.6), height: geo.size.height, alignment: .leading)
                            .transition(.move(edge: .leading))
                            .offset(x: (geo.size.width * -0.2))
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
