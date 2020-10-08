//
//  Consts.swift
//  GameComparison
//
//  Created by Personal on 9/12/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import Foundation

struct Consts {
    public class KeychainKeys {
        public static let Username = "Username"
    }
    
    public class URLs {
        public static var APIBaseURL = "https://gamecompare.azurewebsites.net/api"
        
//            public static var APIBaseURL = "http://localhost:7071/api"
        public static var APIFunctionKey = "F8KpIclG5DNThaiayIOCkV500mOVruFjLYrCBEenj7OTykMV/UjLDw=="
    }
    
    public class UserDefaultsKeys {
        public static let TermsAccepted = "TermsAccepted"
        public static let LoadLibrary = "LoadLibrary"
        public static let TermsSaved = "TermsSaved"
    }
    
    public class AppSettings {
        public static let AppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "1.0"
    }
    
    public class TermsOfUse {
        public static func loadTerms() -> String? {
            if let filepath = Bundle.main.path(forResource: "TermsOfUse", ofType: "txt") {
                do {
                    let terms = try String(contentsOfFile: filepath)
                    return terms
                } catch {
                    AnalysticsService.shared.logException(exception: CustomError.runtimeError("Error parsing terms of use", error))
                }
            
            }
            AnalysticsService.shared.logMessage("Terms of Use file not found")
            return nil
        }
    }
}
