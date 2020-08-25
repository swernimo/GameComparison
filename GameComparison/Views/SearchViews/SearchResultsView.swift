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
    @State var showCloseButton: Bool = false
    @State var closeBtnCallback: (() -> ())? = nil
    var body: some View {
        GeometryReader { geo in
            VStack{
                if(self.showCloseButton) {
                    HStack{
                        Button(action: ({
                            guard let closure = self.closeBtnCallback
                                else { return }
                            closure()
                        })) {
                            Image(systemName: "xmark.circle")
                                .imageScale(.medium)
                                .font(.title)
                                .foregroundColor(.black)
                        }
                        .padding(.trailing, 15)
                        .padding(.top, 10)
                    }
                    .frame(width: geo.size.width, height: (geo.size.height * 0.05), alignment: .trailing)
                .frame(minWidth: 15)
                }
                List{
                    ForEach(self.resultsObservable.results, id: \.id) { item in
                       SearchResultsItemView(result: item)
                        .frame(width: geo.size.width, height: 110, alignment: .leading)
                    }
                }.frame(minWidth: 100, minHeight: 100, alignment: .leading)
            }
        }
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView(showCloseButton: true)
            .environmentObject(SearchResultObersable())
    }
}
