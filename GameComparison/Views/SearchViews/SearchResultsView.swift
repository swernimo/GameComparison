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
    @EnvironmentObject var resultsObservable: SearchResultObersable
    @State var image: Image? = nil
    var body: some View {
        List{
            //TODO: set the line item for each time to be consisent
            ForEach(self.resultsObservable.results, id: \.id) { item in
               SearchResultsItemView(result: item)
            }
        }
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView()
        .environmentObject(SearchResultObersable())
    }
}
