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
    }
    
    public class AppSettings {
        public static let AppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "1.0"
    }
}
