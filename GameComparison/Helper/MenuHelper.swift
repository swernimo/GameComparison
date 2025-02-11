//
//  MenuHelper.swift
//  CDSideMenuExample
//
//  Created by Personal on 10/2/20.
//  Copyright © 2020 Chris Dlc. All rights reserved.
//

import Foundation
import SwiftUI

class MenuHelper {
    public static let shared = MenuHelper()
    
    /// Conforms to CDSideMenuConfigurator protocol
    func didLogout(_ notification: Notification) {
        AnalysticsService.shared.logButtonClick("Logout", pageName: "Menu")
        KeychainWrapper.shared.removeObject(forKey: Consts.KeychainKeys.Username)
        CoreDataService.shared.deleteAllData()
        UserDefaultsService.shared.setLoadGameLibrary(true)
    }
    
    /// Conforms to CDSideMenuConfigurator protocol
    func createConfiguration() -> CDSideMenuConfiguration {
        var menuItems = [CDSideMenuItem]()
        menuItems.append(CDSideMenuItem(title: "My Library", sfImage: "house", view: AnyView(HomeView())))
        menuItems.append(CDSideMenuItem(title: "Search by Barcode", sfImage: "barcode.viewfinder", view: AnyView(ScannerView())))
        menuItems.append(CDSideMenuItem(title: "Search by Title", sfImage: "doc.text.magnifyingglass", view: AnyView(SearchByTitleView(results: SearchResultObersable()))))
        menuItems.append(CDSideMenuItem(title: "About", sfImage: "", view: AnyView(AboutView())))
        menuItems.append(CDSideMenuItem(title: "Terms of Use", sfImage: "book", view: AnyView(TermsOfUseView())))

//         If planning to use the logout button, register to the following event to be notified when the user clicks the logout button
        NotificationCenter.default.addObserver(forName: Notification.Name(CDSideMenuNotification.logout.rawValue),
                                               object: nil, queue: nil, using: self.didLogout)
        
        do {
            return try CDSideMenuConfiguration(navigationBarHidden: false,
                                               accountViewHidden: true,
                                               menuBackgroundColor: .cdDarkGray,
                                               menuForegroundColor: .white,
                                               viewsBackgroundColor: .white,
                                               menuFont: Font.system(.body, design: .rounded),
                                               menuButtonSize: 20,
                                               menuSizeFactor: 1,
                                               openedMenuButtonSFImage: "line.horizontal.3",
                                               closedMenuButtonSFImage: "line.horizontal.3",
                                               menuItems: menuItems,
                                               userData: CDUserData(userName: "Chris", imageUrl: ""))
        }
        catch {
            AnalysticsService.shared.logException(exception: CustomError.runtimeError("CDSideMenu configuration failed.", error))
            return try! CDSideMenuConfiguration(accountViewHidden: true, menuItems: menuItems)
        }
    }
    
}
