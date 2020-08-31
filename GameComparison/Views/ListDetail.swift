
//  ListDetail.swift
//  GameComparison
//
//  Created by Personal on 7/30/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct ListDetail: View {
    @State var game: Game
    @State private var addBarcode: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    Text(self.game.name)
                    GameCoverImage(imageFilePath: self.game.imageFilePath, image: Image(systemName: "xmark.square"))
                    .frame(height: geo.size.height / 2)
                    if (self.game.statistics != nil) {
                        VStack {
                            HStack{
                                Text("Complexity: \(String(format: "%.2f", self.game.statistics!.complexity)) / 5")
                                Spacer()
                                Text("Community rating: \(String(format: "%.1f", self.game.statistics!.rating)) / 10")
                            }
                            HStack {
                                Text("Playing Time: \(self.game.statistics!.playingTime) minutes")
                            }
                            HStack {
                                Text("Manufacturer Player Age: \(self.game.statistics!.playerAge)")
                            }
                            HStack{
                                Text("Community Suggested Player age: \(self.game.statistics!.suggestedPlayerAge)")
                            }
                            HStack{
                                Text("Minimum Players: \(self.game.statistics!.minPlayers)")
                                Text("Maximum Players: \(self.game.statistics!.maxPlayers)")
                            }
                            HStack{
                                Text("Community Suggested Players: \(self.game.statistics!.recommendedPlayers)")
                            }
                        }
                    }
                }
                if (self.addBarcode) {
                    AddBarcodeView(codeFoundCallback: { code in
                        self.addBarcode.toggle()
                    })
                        .transition(.move(edge: .bottom))
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                }
            }
        }
        .navigationBarItems(trailing: Button(action: {
            self.addBarcode.toggle()
        }){
          Image(systemName: "barcode.viewfinder")
           .imageScale(.small)
           .font(.title)
        })
    }
}

struct ListDetail_Previews: PreviewProvider {
    static var previews: some View {
        ListDetail(game: gameLibraryPreviewData[0])
    }
}
