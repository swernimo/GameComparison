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
    @State var name: String
    @State private var addBarcode: Bool = false
    var body: some View {
            GeometryReader { geo in
                    VStack {
                        if (self.game != nil) {
                            ScrollView(.vertical, showsIndicators: true) {
                            if(self.image != nil) {
                                self.image!
                                .resizable()
                                    .frame(width: (geo.size.width * 0.8), height: (geo.size.height * 0.4), alignment: .center)
                                    .aspectRatio(contentMode: ContentMode.fit)
                            }
                                //TODO: add flag if game in library
                            HStack{
                                Spacer()
                                Text("This Game")
                                Spacer()
                                Text("Your Library Average")
                                Spacer()
                                Text("Difference")
                                Spacer()
                            }
                            ComparsionRowView(sectionName: "Rating", gameValue: self.game!.rating, libraryAverage: self.libraryStats!.avgRating, difference: self.libraryStats!.getRatingDifference(self.game!),
                                              goodColor: .red, badColor: .green)
                        
                            ComparsionRowView(sectionName: "Complexity", gameValue: self.game!.complexity, libraryAverage: self.libraryStats!.avgComplexity, difference: self.libraryStats!.getComplexityDifference(self.game!))
                        
                            ComparsionRowView(sectionName: "Recommended Player Count", displayFormat: "%0.f", gameValue: Double(self.game!.recommendedPlayers), libraryAverage: self.libraryStats!.avgPlayerCount, difference: self.libraryStats!.getPlayerCountDifference(self.game!))
                        
                            ComparsionRowView(sectionName: "Recommended Player Age", displayFormat: "%0.f", gameValue: Double(self.game!.suggestedPlayerAge), libraryAverage: self.libraryStats!.avgPlayerAge, difference: self.libraryStats!.getPlayerAgeDifference(self.game!))
                    
                            ComparsionRowView(sectionName: "Play Time", displayFormat: "%0.f", gameValue: Double(self.game!.playingTime), libraryAverage: self.libraryStats!.avgPlayTime, difference: self.libraryStats!.getPlayTimeDifference(self.game!))
                       
                            ComparsionRowView(sectionName: "Min Players", displayFormat: "%0.f", gameValue: Double(self.game!.minPlayers), libraryAverage: self.libraryStats!.avgMinPlayerCount, difference: self.libraryStats!.getAvgMinPlayerCount(self.game!))
                       
                            ComparsionRowView(sectionName: "Max Players", displayFormat: "%0.f", gameValue: Double(self.game!.maxPlayers), libraryAverage: self.libraryStats!.avgMaxPlayerCount, difference: self.libraryStats!.getAvgMaxPlayerCount(self.game!))
                            
                        }
                         if (self.addBarcode) {
                            AddBarcodeView(completeCallback: {
                                self.addBarcode = false
                            }, gameId: Int32(self.game!.id), name: self.name)
                            .transition(.move(edge: .bottom))
                            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                        }
                    }
                }.onAppear(perform: {
                    API.searchById(gameId: self.id, completion: { details in
                        if let details = details {
                            self.game = details
                            ImageHelper.shared.retrieveImage(url: self.game!.imageUrl, key: "\(self.game!.id)", completion: { imageData in
                                if let imageData = imageData {
                                    let uiImage = UIImage(data: imageData)!
                                    self.image = Image(uiImage: uiImage)
                                } else {
                                    self.image = Image(systemName: "xmark.square")
                                }
                            })
                        }
                    })
                    let gameLibrary = CoreDataService.shared.fetchGameLibrary()
                    self.libraryStats = LibraryStats(from: gameLibrary)
                })
                .navigationBarTitle(self.name)
                .navigationBarItems(trailing: Button(action: {
                    self.addBarcode.toggle()
                }){
                    if (self.addBarcode) {
                        Image(systemName: "xmark.circle")
                         .imageScale(.small)
                         .font(.title)
                    } else {
                        Image(systemName: "barcode.viewfinder")
                         .imageScale(.small)
                         .font(.title)
                    }
                })
        }
    }
}

struct SearchDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        
        /* ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
                   LandmarkList()
                       .previewDevice(PreviewDevice(rawValue: deviceName))
                       .previewDisplayName(deviceName)
               }
               .environmentObject(UserData())
         **/
        SearchDetailsView(game: gameComparisonPreviewData, id: 123, image: Image(systemName: "xmark.square"), libraryStats: LibraryStats(from: gameLibraryPreviewData), name: "Boss Monster")
    }
}
