//
//  ContentView.swift
//  GameComparison
//
//  Created by Sean Wernimont on 7/10/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var helper: ScannerHelper
    
    var appDelegate = (UIApplication.shared.delegate as? AppDelegate)
    
    var body: some View {
        HomeView(collection: [])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .environmentObject(ScannerHelper())
    }
}
