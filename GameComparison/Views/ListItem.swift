//
//  ListItem.swift
//  GameComparison
//
//  Created by Personal on 7/29/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct ListItem: View {
    @State var collectionItem: CollectionItem
    @State var image: Image
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                self.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text(self.collectionItem.name)
                Spacer()
            }
            .onAppear(perform: {
                API.downloadImage(url: self.collectionItem.thumbnailUrl, completion: { uiImage in
                    guard let image = uiImage else {
                        self.image = Image(systemName: "xmark.square")
                        return
                    }
                    self.image = Image(uiImage: image)
                })
            })
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(collectionItem: collectionPreviewData[0], image: Image(systemName: "xmark.square"))
    }
}
