//
//  Menu.swift
//  GameComparison
//
//  Created by Personal on 9/6/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    @Binding var showMenu: Bool
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack (alignment: .leading){
                    NavigationLink (destination: AboutView()) {
                        Text("My Library")
                        .padding(.top, 100)
                    }
                    NavigationLink (destination: AboutView()) {
                        Text("About")
                        .padding(.top, 20)
                    }
                    Spacer()
                    Button(action: {
                        /*
                         TODO:
                            login user out
                            clear their game library from core data
                            clear their username from keychain
                            redirect to home
                         **/
                    }){
                        Text("Logout")
                    }.padding(.leading, (geo.size.width * 0.35))
                }
                .foregroundColor(.blue)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.white))
                .edgesIgnoringSafeArea(.all)
                .navigationBarItems(leading: HamburgerButtonView(showMenu: self.$showMenu))
            }
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(showMenu: .constant(true))
//        MenuView()
    }
}
