//
//  Library.swift
//  GameComparison
//
//  Created by Personal on 8/3/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import Foundation
import Combine

class Library: ObservableObject {
    @Published var library: [Game] = []
}
