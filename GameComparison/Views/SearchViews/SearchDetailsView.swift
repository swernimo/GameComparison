//
//  SearchDetailsView.swift
//  GameComparison
//
//  Created by Personal on 8/15/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI
import Foundation

struct SearchDetailsView: View {
    @State var game: GameComparisonObject? = nil
    @State var id: Int
    @State var image: Image? = nil
    @State var libraryStats: LibraryStats? = nil
    var body: some View {
        GeometryReader { geo in
            VStack {
                if (self.game != nil) {
                    //self.navigationBarTitle(self.game!.name)
                    Text(self.game!.name)
                        .font(.title)
                    if(self.image != nil) {
                        self.image!
                        .resizable()
                            .frame(width: geo.size.width, height: (geo.size.height / 3), alignment: .center)
                            .aspectRatio(contentMode: ContentMode.fit)
                    }
                    VStack{
                        HStack{
                            Spacer()
                            Text("This Game")
                            Spacer()
                            Text("Your Library Average")
                            Spacer()
                            Text("Difference")
                            Spacer()
                        }
                        ComparsionRowView(sectionName: "Rating", gameValue: self.game!.rating, libraryAverage: self.libraryStats!.avgRating, difference: self.libraryStats!.getRatingDifference(self.game!))
                        ComparsionRowView(sectionName: "Complexity", gameValue: self.game!.complexity, libraryAverage: self.libraryStats!.avgComplexity, difference: self.libraryStats!.getComplexityDifference(self.game!))
                        ComparsionRowView(sectionName: "Player Count", displayFormat: "%0.f", gameValue: Double(self.game!.recommendedPlayers), libraryAverage: self.libraryStats!.avgPlayerCount, difference: self.libraryStats!.getPlayerCountDifference(self.game!))
                    }
                }
            }.onAppear(perform: {
                API.searchById(gameId: self.id, completion: { details in
                    if let details = details {
                        self.game = details
                        API.downloadImage(url: details.imageUrl, completion: { imageData in
                            if let data = imageData {
                                guard let uiImage = UIImage(data: data)
                                    else { return }
                                self.image = Image(uiImage: uiImage)
                            }
                        })
                    }
                })
                let gameLibrary = CoreDataService.shared.fetchGameLibrary()
                self.libraryStats = LibraryStats(from: gameLibrary)
            })
        }
    }
}

struct SearchDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchDetailsView(game: gameComparisonPreviewData, id: 123, image: Image(systemName: "xmark.square"), libraryStats: nil)
    }
}
