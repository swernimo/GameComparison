//
//  SearchResultsViewController.swift
//  GameComparison
//
//  Created by Personal on 8/13/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import Foundation
import AVFoundation
import SwiftUI

struct SearchResultsView: View {
    @State var searchResults: [SearchResult] = []
    @State var image: Image? = nil
    var body: some View {
        List{
            ForEach(self.searchResults, id: \.id) { item in
               SearchResultsItemView(result: item)
            }.onAppear(perform: {
                print("Foreach on appear triggered")
            })
        }
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView()
    }
}
