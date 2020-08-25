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
    @State private var disableSearch = false
    var results: SearchResultObersable
    
    var body: some View {
        GeometryReader { geo in
            VStack{
                HStack{
                    //TODO: pin the textfield and button to the top of the page
                    //TODO: when navigating back to Scan Barcode page clear results
                    TextField("Enter Game Title", text: self.$title)
                        .border(Color.black, width: 1)
                        .frame(width: (geo.size.width * 0.7), height: 15, alignment: .trailing)
                        .padding(.leading, (geo.size.width * 0.05))
                        .padding(.top, (geo.size.height * 0.03))
                    Button("Search", action: {
                        if (self.title != "") {
                            self.disableSearch = true
                            //TODO: clear existing results when searching
                            //TODO: show loading animation
                            //TODO: search on keyboard return
                            API.searchByTitle(title: self.title, completion: { results in
                            //TODO: dismiss keyboard
                                self.disableSearch = false
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
                    .disabled(self.disableSearch)
                    .padding(.top, (geo.size.height * 0.03))
                }
                .frame(width: geo.size.width, alignment: .leading)
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
}

struct SearchByTitleView_Previews: PreviewProvider {
    static var previews: some View {
        SearchByTitleView(results: SearchResultObersable())
    }
}
