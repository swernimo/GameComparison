//
//  ScannerHelper.swift
//  GameComparison
//
//  Created by Personal on 7/15/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import Combine
import SwiftUI

class ScannerHelper: ObservableObject {
    @Published var failed = false
    @Published var code = ""
}
