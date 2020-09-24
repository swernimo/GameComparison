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
    @State private var showLoading = false
    var results: SearchResultObersable
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack{
                    HStack{
                        //TODO: pin the textfield and button to the top of the page
                        TextField("Enter Game Title", text: self.$title)
                            .border(Color.black, width: 1)
                            .frame(width: (geo.size.width * 0.7), height: 15, alignment: .trailing)
                            .padding(.leading, (geo.size.width * 0.05))
                            .padding(.top, (geo.size.height * 0.03))
                        Button("Search", action: {
                            if (self.title != "") {
                                AnalysticsService.shared.logButtonClick("Search", pageName: "Search by Title")
                                self.disableSearch = true
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                self.showLoading = true
                                API.searchByTitle(title: self.title, completion: { results in
                                    self.disableSearch = false
                                    self.showLoading = false
                                    if let results = results {
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
                LoadingView(loading: self.$showLoading)
            }
            //TODO: clear the search results only when navigating back
        }/*.navigationBarItems(leading: NavigationLink(destination: ScannerView()) {
            Image(systemName: "chevron.left")
        }).simultaneousGesture(TapGesture().onEnded({
            self.results.results = []
        }))*/
        .onAppear(perform: {
            AnalysticsService.shared.logPageView("Search by Title")
        })
    }
}

struct SearchByTitleView_Previews: PreviewProvider {
    static var previews: some View {
        SearchByTitleView(results: SearchResultObersable())
    }
}
