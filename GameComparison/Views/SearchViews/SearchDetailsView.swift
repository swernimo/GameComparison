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
    @State var image: UIImage? = nil
    @State var libraryStats: LibraryStats? = nil
    var body: some View {
        GeometryReader { geo in
            VStack {
                if (self.game != nil) {
                    //self.navigationBarTitle(self.game!.name)
                    Text(self.game!.name)
                        .font(.title)
                    if(self.image != nil) {
                        Image(uiImage: self.image!)
                        .resizable()
                            .frame(width: geo.size.width, height: (geo.size.height / 3), alignment: .center)
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
                            Text("\(String(format: "%.1f", self.game!.rating))")
                                .frame(alignment: .leading)
                            Spacer()
                            Text("\(String(format: "%.1f", self.libraryStats!.getAverageRating()))")
                            Spacer()
                            Text("\(String(format: "%.1f", self.game!.rating - self.libraryStats!.getAverageRating()))")
                                .foregroundColor((self.game!.rating > self.libraryStats!.getAverageRating()) ? .green : .red)
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
                                self.image = uiImage
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
        SearchDetailsView(id: 123)
    }
}
