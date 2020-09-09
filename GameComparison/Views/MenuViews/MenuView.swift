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
                        Text("Home")
                        .padding(.top, 100)
                    }
                    NavigationLink (destination: AboutView()) {
                        Text("About Page")
                        .padding(.top, 20)
                    }
                    Spacer()
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
