//
//  Menu.swift
//  GameComparison
//
//  Created by Personal on 9/6/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct MenuView: View {
//    @Binding var showMenu: Bool
    var body: some View {
        VStack{
//            NavigationLink (destination: AboutView()) {
                    Text("Menu Page")
//                }
        }
        .navigationBarItems(leading: Image(systemName: ""))
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
//        MenuView(showMenu: .constant(true))
        MenuView()
    }
}
