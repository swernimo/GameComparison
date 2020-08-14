//
//  SearchResultObservable.swift
//  GameComparison
//
//  Created by Personal on 8/14/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import Foundation
import SwiftUI

class SearchResultObersable: ObservableObject {
    @Published var results: [SearchResult] = []
}
