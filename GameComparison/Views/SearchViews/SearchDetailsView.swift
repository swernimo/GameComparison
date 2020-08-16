//
//  SearchDetailsView.swift
//  GameComparison
//
//  Created by Personal on 8/15/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct SearchDetailsView: View {
    @State var game: GameComparison = GameComparison()
    @State var id: Int
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }.onAppear(perform: {
            //get game details
            API.searchById(gameId: self.id, completion: { details in
                if let details = details {
                    self.game = details
                }
            })
        })
//        .navigationBarTitle(self.game.name)
    }
}

struct SearchDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchDetailsView(id: 123)
    }
}
