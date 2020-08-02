//
//  GameCoverImage.swift
//  GameComparison
//
//  Created by Personal on 7/30/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct GameCoverImage: View {
    @State var imageURL: String
    @State var image: Image
    
    var body: some View {
        GeometryReader { geo in
            VStack{
                self.image
                .resizable()
            }.onAppear(perform: {
                API.downloadImage(url: self.imageURL, completion: { imageData in
//                    guard let image = imageData else {
//                        self.image = Image(systemName: "xmark.square")
//                        return
//                    }
//                    self.image = Image(uiImage: UIImage(data: imageData))
                })
            })
        }
    }
    
}

struct GameCoverImage_Previews: PreviewProvider {
    static var previews: some View {
        GameCoverImage(imageURL: "https://cf.geekdo-images.com/original/img/A-0yDJkve0avEicYQ4HoNO-HkK8=/0x0/pic2419375.jpg", image: Image(systemName: "xmark.square"))
    }
}
