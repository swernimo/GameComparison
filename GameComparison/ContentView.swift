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
//        GeometryReader { geo in
//            ZStack {
                HomeView()
//                    .overlay(ListView()
//                        .frame(width: geo.size.width, height: geo.size.width * 1.75))
//            }
//            .onDisappear(perform: ({
//                self.appDelegate?.saveContext()
//            }))
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .environmentObject(ScannerHelper())
    }
}
