//
//  SearchByTitleView.swift
//  GameComparison
//
//  Created by Personal on 8/14/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct SearchByTitleView: View {
    @State private var title: String = ""
    @State private var showNoResults = false
    var results: SearchResultObersable
    
    var body: some View {
        VStack{
            HStack{
                TextField("Enter Game Title", text: $title)
                    .border(Color.black, width: 1)
                Button("Search", action: {
                    print("searching for game with title \(self.title)")
                    if (self.title != "") {
                        API.searchByTitle(title: self.title, completion: { results in
                            if let results = results{
                                DispatchQueue.main.async {
                                    if (results.count > 0) {
                                        self.results.results = results
                                        self.showNoResults = false
                                    } else {
                                        self.results.results = []
                                        self.showNoResults = true
                                    }
                                
                                }
                            }
                        })
                    }
                })
            }
            if (self.showNoResults) {
                Text("No results. Please try again")
            } else {
                SearchResultsView(image: nil)
                    .environmentObject(self.results)
            }
        }
    }
}

struct SearchByTitleView_Previews: PreviewProvider {
    static var previews: some View {
        SearchByTitleView(results: SearchResultObersable())
    }
}
