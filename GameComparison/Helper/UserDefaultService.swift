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
    
    func getShouldLoadGameLibrary() -> Bool {
        let obj = defaults.object(forKey: Consts.UserDefaultsKeys.LoadLibrary)
        if (obj == nil) {
            return true
        }
        return defaults.bool(forKey: Consts.UserDefaultsKeys.LoadLibrary)
    }
    
    func setLoadGameLibrary(_ shouldLoad: Bool) -> Void {
        defaults.set(shouldLoad, forKey: Consts.UserDefaultsKeys.LoadLibrary)
    }
    
    func getTermsSaved() -> Bool {
        return defaults.bool(forKey: Consts.UserDefaultsKeys.TermsSaved)
    }
    
    func setTermsSaved(_ saved: Bool) -> Void {
        defaults.setValue(saved, forKey: Consts.UserDefaultsKeys.TermsSaved)
    }
}
