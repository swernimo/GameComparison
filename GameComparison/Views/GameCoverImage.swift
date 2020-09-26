//
//  GameCoverImage.swift
//  GameComparison
//
//  Created by Personal on 7/30/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct GameCoverImage: View {
    @State var imageFilePath: String
    @State var image: Image
    
    var body: some View {
        GeometryReader { geo in
            VStack{
                self.image
                .resizable()
            }.onAppear(perform: {
                ImageHelper.shared.retrieveImage(url: nil, key: self.imageFilePath, completion: { imageData in
                        self.image = ImageHelper.shared.getImage(data: imageData)
                })
            })
        }
    }
    
}

struct GameCoverImage_Previews: PreviewProvider {
    static var previews: some View {
        GameCoverImage(imageFilePath: "filePath", image: Image(systemName: "xmark.square"))
    }
}
