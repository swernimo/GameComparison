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
    
    var body: some View {
        HeaderView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .environmentObject(ScannerHelper())
    }
}
