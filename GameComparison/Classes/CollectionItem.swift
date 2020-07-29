//
//  CollectionItem.swift
//  GameComparison
//
//  Created by Personal on 7/28/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import Foundation

struct CollectionItem: Decodable {
    var objectType: String
    var id: Int32
    var subType: String
    var name: String
    var yearPublished: Int32
    var imageUrl: String
    var thumbnailUrl: String
    var owned: Bool
    var numberPlays: Int32
}
