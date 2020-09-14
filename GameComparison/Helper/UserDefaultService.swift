//
//  UserDefaultService.swift
//  GameComparison
//
//  Created by Personal on 9/13/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import Foundation

class UserDefaultsService {
    private init() {}
    
    static let shared = UserDefaultsService()
    
    private let defaults = UserDefaults.standard
    
    func setTermsAccepted(_ accepted: Bool) -> Void {
        defaults.set(accepted, forKey: Consts.UserDefaultsKeys.TermsAccepted)
    }
    
    func getTermsAccepted() -> Bool {
        return defaults.bool(forKey: Consts.UserDefaultsKeys.TermsAccepted)
    }
}
