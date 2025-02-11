//
//  HamburgerButtonView.swift
//  GameComparison
//
//  Created by Personal on 9/8/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct HamburgerButtonView: View {
    @Binding var showMenu: Bool
    var body: some View {
        Button(action: {
            self.showMenu.toggle()
            if (self.showMenu) {
                AnalysticsService.shared.logButtonClick("Show Menu", pageName: "Menu")
            } else {
                AnalysticsService.shared.logButtonClick("Hide Menu", pageName: "Menu")
            }
        }){
          Image(systemName: "line.horizontal.3")
            .imageScale(.small)
            .font(.title)
        }
    }
}

struct HamburgerButtonView_Previews: PreviewProvider {
    static var previews: some View {
//        HamburgerButtonView()
        HamburgerButtonView(showMenu: .constant(true))
    }
}
