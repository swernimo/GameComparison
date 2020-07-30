//
//  ListItem.swift
//  GameComparison
//
//  Created by Personal on 7/29/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct ListItem: View {
    @State var collectionItem: CollectionItem
    
    var body: some View {
        HStack {
            Image(systemName: "wifi.slash")
            Text(collectionItem.name)
            Spacer()
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(collectionItem: CollectionItem())
    }
}
