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
                guard let uiImage = UIImage(data: imageData!) else {
                    self.image = Image(systemName: "xmark.square")
                    return
                }
                self.image = Image(uiImage: uiImage)
            })
        })
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(game: gameLibraryPreviewData[0])
    }
}
