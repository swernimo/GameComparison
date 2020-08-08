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
    @State var stats: GameStatistics?
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                GameCoverImage(imageFilePath: self.game.imageFilePath, image: Image(systemName: "xmark.square"))
                .frame(height: geo.size.height / 2)
                Text(self.game.name)
                if (self.stats != nil) {
                    VStack {
                        HStack{
                            Text("Complexity: \(String(format: "%.2f", self.stats!.complexity)) / 5")
                            Spacer()
                            Text("Community rating: \(String(format: "%.1f", self.stats!.rating)) / 10")
                        }
                        HStack {
                            Text("Playing Time: \(self.stats!.playingTime) minutes")
                        }
                        HStack {
                            Text("Manufacturer Player Age: \(self.stats!.playerAge)")
                        }
                        HStack{
                            Text("Community Suggested Player age: \(self.stats!.suggestedPlayerAge)")
                        }
                        HStack{
                            Text("Minimum Players: \(self.stats!.minPlayers)")
                            Text("Maximum Players: \(self.stats!.maxPlayers)")
                        }
                        HStack{
                            Text("Community Suggested Players: \(self.stats!.recommendedPlayers)")
                        }
                    }
                }
            }
        }.onAppear(perform: {
            if (self.game.statistics == nil) {
                API.getGameStatistics(id: self.game.id, completion: { gameStats in
                    if (gameStats != nil) {
                        self.game.statistics = gameStats
                        gameStats!.game = self.game
                        self.stats = gameStats!
                        CoreDataService.shared.saveContext()
                    }
                })
            }
        })
    }
}

struct ListDetail_Previews: PreviewProvider {
    static var previews: some View {
        ListDetail(game: Game(), stats: GameStatistics())
    }
}
