//
//  SearchResultsItemView.swift
//  GameComparison
//
//  Created by Personal on 8/14/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct SearchResultsItemView: View {
    @State var result: SearchResult
    @State var image: Image? = nil
    
    var body: some View {
         HStack {
            NavigationLink (destination: SearchDetailsView(id: self.result.id, name: self.result.title)){
                if(self.image != nil) {
                    self.image!
                    .resizable()
                        .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fit)
                }
                Text(result.title)
            }
       }.onAppear(perform: {
        ImageHelper.shared.retrieveImage(url: self.result.imageURL, key: "\(self.result.id)"
            , completion: { data in
                if let imageData = data {
                    let uiImage = UIImage(data: imageData)!
                    self.image = Image(uiImage: uiImage)
                } else {
                    self.image = Image(systemName: "xmark.square")
                }
        })
       })
    }
}

struct SearchResultsItemView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsItemView(result: searchResultsPreviewData[0], image: Image(systemName: "xmark.square"))
    }
}
