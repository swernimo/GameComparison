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
                HomeView()
                    .environmentObject(self.library)
            } else {
                TermsOfUseView()
                    .environmentObject(self.library)
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
