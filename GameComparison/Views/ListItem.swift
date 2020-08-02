//
//  ListItem.swift
//  GameComparison
//
//  Created by Personal on 7/29/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct ListItem: View {
    @State var game: Game
    
    @ViewBuilder
    var body: some View {
        GeometryReader { geo in
            HStack {
                if (self.game.image != nil) {
                    Image(uiImage: UIImage(data: self.game.image!)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                } else {
                    Image(systemName: "xmark.square")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                }
                Text(self.game.name)
                Spacer()
            }
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(game: Game())
    }
}
