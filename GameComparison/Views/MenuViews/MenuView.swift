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
                    NavigationLink (destination: HomeView()) {
                        Text("My Library")
                        .padding(.top, 100)
                    }.gesture(TapGesture().onEnded({
                        AnalysticsService.shared.logButtonClick("My Library", pageName: "Menu")
                    }))
                    NavigationLink (destination: AboutView()) {
                        Text("About")
                        .padding(.top, 20)
                    }.gesture(TapGesture().onEnded({
                        AnalysticsService.shared.logButtonClick("About", pageName: "Menu")
                    }))
                    NavigationLink (destination: TermsOfUseView()) {
                        Text("Terms of Use")
                            .padding(.top, 20)
                    }.gesture(TapGesture().onEnded({
                        AnalysticsService.shared.logButtonClick("Terms of Use", pageName: "Menu")
                    }))
                    Spacer()
                    NavigationLink (destination: ContentView()) {
                        Text("Logout")
                            .padding(.leading, (geo.size.width * 0.35))
                    }.simultaneousGesture(TapGesture().onEnded({
                        AnalysticsService.shared.logButtonClick("Logout", pageName: "Menu")
                        KeychainWrapper.shared.removeObject(forKey: Consts.KeychainKeys.Username)
                        CoreDataService.shared.deleteAllData()
                        self.showMenu = false
                    }))
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
    }
}
