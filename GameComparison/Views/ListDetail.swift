
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
    @State private var showDescription: Bool = false
    @State var gameDescription: String = ""
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    Text(self.game.name)
                    GameCoverImage(imageFilePath: self.game.imageFilePath, image: Image(systemName: "xmark.square"))
                    .frame(height: geo.size.height / 2)
                    if (self.game.statistics != nil) {
                        VStack {
                            if (self.game.statistics?.desc != nil) {
                                Text(self.game.statistics?.desc ?? "")
                                    .font(.subheadline)
                                    .frame(maxWidth: (geo.size.width), maxHeight: (geo.size.height * 0.1))
                                    .gesture(TapGesture()
                                        .onEnded{ _ in
                                            self.gameDescription = self.game.statistics!.desc
                                            self.showDescription = true
                                        })
                            }
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
                        .padding(.leading, (geo.size.width * 0.01))
                    }
                }
                if (self.addBarcode) {
                    AddBarcodeView(completeCallback: {
                        self.addBarcode = false
                    }, gameId: self.game.id, name: self.game.name)
                    .transition(.move(edge: .bottom))
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                }
            }
        }
        .sheet(isPresented: self.$showDescription) {
            Text("Swipe down to close")
                .font(.footnote)
            ScrollView{
                HTMLStringView(htmlContent: self.game.statistics!.desc)
                    .frame(height: 800)
                Text(self.game.statistics!.desc)
                .frame(width: 1, height: 1)
                .hidden()
            }
            .padding(.leading, 10)
        }
        .navigationBarItems(leading: NavigationLink(
                                destination: HomeView(),
                                label: {
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(.blue)
                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                }), trailing: Button(action: {
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
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            AnalysticsService.shared.logPageView("Game Library Item Detail")
        })
    }
}

struct ListDetail_Previews: PreviewProvider {
    static var previews: some View {
        ListDetail(game: gameLibraryPreviewData[0])
    }
}
