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
    var body: some View {
        List{
            ForEach(self.searchResults, id: \.id) { item in
                HStack {
                    Image(systemName: "xmark.square")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fit)
                    Text(item.title)
                }
            }
        }
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView(searchResults: searchResultsPreviewData)
    }
}
