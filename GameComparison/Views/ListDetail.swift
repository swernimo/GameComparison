//
//  ListDetail.swift
//  GameComparison
//
//  Created by Personal on 7/30/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct ListDetail: View {
    @State var game: Game
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                GameCoverImage(imageFilePath: self.game.imageFilePath, image: Image(systemName: "xmark.square"))
                .frame(height: geo.size.height / 2)
                Text(self.game.name)
            }
            
        }
    }
}

struct ListDetail_Previews: PreviewProvider {
    static var previews: some View {
        ListDetail(game: Game())
    }
}
