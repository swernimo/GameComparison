//
//  CustomError.swift
//  GameComparison
//
//  Created by Personal on 9/30/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case runtimeError(String, Error)
}
