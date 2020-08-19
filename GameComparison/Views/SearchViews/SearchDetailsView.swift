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
    @State var game: GameComparison? = nil
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
                        Text("Rating")
                        HStack{
                            Spacer()
                            Text("\(String(format: "%.2f", self.game!.rating))")
                                .frame(alignment: .leading)
                            Spacer()
                            Text("\(String(format: "%.2f", self.libraryStats!.avgRating))")
                            Spacer()
                            
                            Image(systemName: (self.game!.rating > self.libraryStats!.avgRating) ? "arrow.up" : "arrow.down")
                                .resizable()
                                .frame(width: 10, height: 10, alignment: .trailing)
                                .foregroundColor((self.game!.rating > self.libraryStats!.avgRating) ? .green : .red)
                            Text("\(String(format: "%.2f", self.libraryStats!.getRatingDifference(self.game!)))")
                                .foregroundColor((self.game!.rating > self.libraryStats!.avgRating) ? .green : .red)
                                .frame(alignment: .center)
                            Spacer()
                        }
                        Text("Complexity")
                        HStack{
                            Spacer()
                            Text("\(String(format: "%.2f", self.game!.complexity))")
                                .frame(alignment: .leading)
                            Spacer()
                            Text("\(String(format: "%.2f", self.libraryStats!.avgComplexity))")
                            Spacer()
                            
                            Image(systemName: (self.game!.complexity > self.libraryStats!.avgComplexity) ? "arrow.up" : "arrow.down")
                                .resizable()
                                .frame(width: 10, height: 10, alignment: .trailing)
                                .foregroundColor((self.game!.complexity > self.libraryStats!.avgComplexity) ? .green : .red)
                            Text("\(String(format: "%.2f", self.libraryStats!.getComplexityDifference(self.game!)))")
                                .foregroundColor((self.game!.complexity > self.libraryStats!.avgComplexity) ? .green : .red)
                                .frame(alignment: .center)
                            Spacer()
                        }
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
