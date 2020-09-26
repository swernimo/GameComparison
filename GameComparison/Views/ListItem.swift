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
    @State var image: Image? = nil
    
    @ViewBuilder
    var body: some View {
        GeometryReader { geo in
            HStack {
                if (self.image != nil) {
                    self.image!
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                }
                Text(self.game.name)
                Spacer()
            }
        }.onAppear(perform: {
            ImageHelper.shared.retrieveImage(url: self.game.imageUrl, key: self.game.imageFilePath, completion: { imageData in
                self.image = ImageHelper.shared.getImage(data: imageData)
            })
        })
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(game: gameLibraryPreviewData[0])
    }
}
