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
                //TODO: pin the textfield and button to the top of the page
                //TODO: when navigating back to Scan Barcode page clear results
                //TODO: adjust size of textfield
                //TODO: style the button and disable while a search is happening
                TextField("Enter Game Title", text: $title)
                    .border(Color.black, width: 1)
                Button("Search", action: {
                    if (self.title != "") {
                        //TODO: clear existing results when searching
                        //TODO: show loading animation
                        //TODO: search on keyboard return
                        API.searchByTitle(title: self.title, completion: { results in
                        //TODO: dismiss keyboard
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
                //TODO: don't show empty list or empty results message first time into page
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
