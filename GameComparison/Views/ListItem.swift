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
            if let imageData = UserDefaults.standard.object(forKey: self.game.imageFilePath) as? Data {
                    let uiImage = UIImage(data: imageData)!
                    self.image = Image(uiImage: uiImage)
            } else {
                API.downloadImage(url: self.game.imageUrl, completion: { data in
                    if (data != nil) {
                        UserDefaults.standard.set(data, forKey: self.game.imageFilePath)
                        let uiImage = UIImage(data: data!)!
                        self.image = Image(uiImage: uiImage)
                    }
                })
            }
        })
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(game: gameLibraryPreviewData[0])
    }
}
