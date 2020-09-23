//
//  AboutView.swift
//  GameComparison
//
//  Created by Personal on 9/6/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            Text("About page")
        }
        .navigationBarTitle("About")
        .onAppear(perform: {
            AnalysticsService.shared.logPageView("About")
        })
    }
    
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
