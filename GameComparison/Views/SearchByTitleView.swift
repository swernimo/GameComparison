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
    @State private var searchResults: [SearchResult] = []
    @State private var showNoResults = false
    
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
                                if (results.count > 0) {
                                    self.searchResults = results
                                    print("Number of search results found: \(self.searchResults.count)")
                                    self.showNoResults = false
                                } else {
                                    print("No search results found")
                                    self.searchResults = []
                                    self.showNoResults = true
                                }
                            }
                        })
                    }
                })
            }
            if (self.showNoResults) {
                Text("No results. Please try again")
            } else {
                SearchResultsView(searchResults: self.searchResults, image: nil).onAppear(perform: {
                    print("Search By Title View. Search Results View On Appear")
                })
            }
        }
    }
}

struct SearchByTitleView_Previews: PreviewProvider {
    static var previews: some View {
        SearchByTitleView()
    }
}
