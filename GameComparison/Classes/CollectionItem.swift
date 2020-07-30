//
//  CollectionItem.swift
//  GameComparison
//
//  Created by Personal on 7/28/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import Foundation

final class CollectionItem: Decodable, ObservableObject, Identifiable {
    
    init() {
        objectType = ""
        id = -1
        subType = ""
        name = ""
        yearPublished = -1
        imageUrl = ""
        thumbnailUrl = ""
        owned = false
        numberPlays = -1
    }
    
    var objectType: String
    var id: Int
    var subType: String
    var name: String
    var yearPublished: Int32
    var imageUrl: String
    var thumbnailUrl: String
    var owned: Bool
    var numberPlays: Int32
}
