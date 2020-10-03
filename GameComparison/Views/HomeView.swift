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
    @State private var promptLogin = false
    @State private var username = ""
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack{
//                    NavigationView {
                        List{
                            ForEach(self.library.library, id: \.id) { item in
                                NavigationLink(destination: ListDetail(game: item)) {
                                    ListItem(game: item)
                                        .frame(height: geo.size.height * 0.1)
                                }
                            }
                        }
//                        .navigationBarTitle("My Game Library", displayMode: .inline)
//                        .navigationBarItems(leading: HamburgerButtonView(showMenu: self.$showMenu), trailing: NavigationLink(destination: ScannerView()){
                        /**
                         leading: NavigationLink(
                                                 destination: CDSideMenuMainView()
                                                     .environmentObject(createConfiguration()),
                                                 label: {
                                                     Image(systemName: "line.horizontal.3")
                                                         .imageScale(.small)
                                                         .font(.title)
                                                 }),
                         */
//                        .navigationBarItems(trailing: NavigationLink(destination: ScannerView()){
//                                Image(systemName: "barcode.viewfinder")
//                                    .imageScale(.small)
//                                    .font(.title)
//                        })
                        
//                    }
//                    .navigationBarBackButtonHidden(true)
//                    .frame(width: geo.size.width)
//                    .offset(x: self.showMenu ? geo.size.width * 0.5 : 0)
//                    .disabled(self.showMenu)
                }
            }.onAppear(perform: {
                AnalysticsService.shared.logPageView("Home")
                if let username = KeychainWrapper.shared.string(forKey: Consts.KeychainKeys.Username) {
                    API(self.library).getGameLibrary(username: username)
                } else {
                    self.promptLogin = true
                }
            })
            .popover(isPresented: self.$promptLogin, content: {
                //TODO: need to style the popover
                VStack {
                    TextField("Enter Boardgame Geek Username", text: self.$username)
                    Button(action: {
                        AnalysticsService.shared.logButtonClick("Login", pageName: "Home")
                        KeychainWrapper.shared.set(self.username, forKey: Consts.KeychainKeys.Username)
                        API(self.library).getGameLibrary(username: self.username)
                        self.promptLogin = false
                    }) {
                        Text("Login")
                    }
                    Spacer()
                    Text("Create Account")
                    //TODO: add link to BGG to create Account
                }
                
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
