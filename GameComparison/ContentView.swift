//
//  ContentView.swift
//  GameComparison
//
//  Created by Sean Wernimont on 7/10/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var library: Library
    @State private var acceptedTerms = false
    
    var appDelegate = (UIApplication.shared.delegate as? AppDelegate)
    
    var body: some View {
        VStack{
            if (acceptedTerms) {
                CDSideMenuMainView()
                    .environmentObject(self.library)
                    .environmentObject(MenuHelper.shared.createConfiguration())
                    .navigationBarHidden(true)
                    .onAppear(perform: {
                        self.acceptedTerms = UserDefaultsService.shared.getTermsAccepted()
                    })
                    .navigationBarTitle("")
            } else {
                NavigationView{
                    TermsOfUseView()
                        .environmentObject(self.library)
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarTitle("Terms of Use")
            }
        }.onAppear(perform: {
            self.acceptedTerms = UserDefaultsService.shared.getTermsAccepted()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .environmentObject(Library())
    }
}
