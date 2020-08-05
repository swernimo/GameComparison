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
//                if (self.game.image != nil) {
//                    Image(uiImage: UIImage(data: self.game.image!)!)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                } else {
//                    Image(systemName: "xmark.square")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                }
                Text(self.game.name)
                Spacer()
            }
        }.onAppear(perform: {
            if (self.game.image != nil) {
                self.image = Image(uiImage: UIImage(data: self.game.image!)!)
            } else{
                API.downloadImage(url: self.game.imageUrl, completion: { data in
                    guard let imageData: Data = data! else {
                        self.image = Image(systemName: "xmark.square")
                        return
                    }
                    self.game.image = imageData
                    CoreDataService.shared.saveContext()
                    let uiImage = UIImage(data: imageData)
                    self.image = Image(uiImage: uiImage!)
//                        self.game.image = data
//                        CoreDataService.shared.saveContext()
//                    guard let uiImage = UIImage(data: data) else  { self.image = Image(systemName: "xmark.square"); return }
//                        self.image = Image(uiImage: uiImage)
                })
            }
        })
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(game: Game())
    }
}
