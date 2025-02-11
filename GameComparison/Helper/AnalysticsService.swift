//
//  AnalysticsService.swift
//  GameComparison
//
//  Created by Personal on 9/22/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAnalytics
import FirebaseCrashlytics

class AnalysticsService {
    static let shared = AnalysticsService()
    
    private let device = UIDevice.current
    
    public func logPageView(_ pageName: String) -> Void {
        let eventParams = getCommonParameters(pageName)
        Analytics.logEvent("PageView", parameters: eventParams)
    }
    
    private func mapModel(_ model: String) -> String {
        //taken from https://medium.com/ios-os-x-development/get-model-info-of-ios-devices-18bc8f32c254
        switch model {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPhone11,2":                              return "iPhone XS"
        case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
        case "iPhone11,8":                              return "iPhone XR"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad7,5", "iPad7,6":                      return "iPad 6"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
        case "i386", "x86_64":                          return "Simulator \(mapModel(ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
        default:                                        return model
        }
    }
    
    private func getCommonParameters(_ pageViewed: String) -> [String: Any] {
        return [
            "OS_Version": device.systemVersion,
            "Device_UUID": device.identifierForVendor ?? "sim device",
            "Device_Name": device.name,
            "Device_Model": mapModel(device.model),
            "Device_SystemName": device.systemName,
            "Device_LocalizedModel": device.localizedModel,
            "Page_Viewed": pageViewed,
            "App_Version": Consts.AppSettings.AppVersion
        ]
    }
    
    public func logButtonClick(_ buttonName: String, pageName: String) -> Void {
        var eventParams = getCommonParameters(pageName)
        eventParams["Button_Clicked"] = buttonName
        Analytics.logEvent("ButtonClicked", parameters: eventParams)
    }
    
    public func logEvent(_ event: String, pageName: String) {
        var params = getCommonParameters(pageName)
        params["Event"] = event
        Analytics.logEvent("Event", parameters: params)
    }
    
    public func logException(exception: CustomError) {
        Crashlytics.crashlytics().record(error: exception)
    }
    
    public func logMessage(_ msg: String) {
        Crashlytics.crashlytics().log(msg)
    }
}
