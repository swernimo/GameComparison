//
//  Header.swift
//  GameComparison
//
//  Created by Personal on 7/20/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI
import CoreImage
import UIKit

struct HomeView: View {
    @EnvironmentObject var library: Library
    @State private var showMenu = false
    @State private var promptLogin = false
    @State private var username = ""
    @State private var termsAccepted = false
    
    private func saveAcceptedTerms() {
        let termsSaved = UserDefaultsService.shared.getTermsSaved()
        termsAccepted = UserDefaultsService.shared.getTermsAccepted()
        if (!termsSaved && termsAccepted) {
            API.saveTerms(completion: { success in
                if (success) {
                    UserDefaultsService.shared.setTermsSaved(true)
                }
            })
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            if (!self.termsAccepted) {
                TermsOfUseView()
                    .navigationBarTitle("Terms of Use")
            } else {
                VStack {
                    List{
                        ForEach(self.library.library, id: \.id) { item in
                            NavigationLink(destination: ListDetail(game: item)) {
                                ListItem(game: item)
                                    .frame(height: geo.size.height * 0.1)
                                    .navigationBarTitle("My Game Library", displayMode: .inline)
                                    .navigationBarBackButtonHidden(true)
                            }
                        }
                    }
                }
            }
        }
        .onAppear(perform: {
            AnalysticsService.shared.logPageView("Home")
            saveAcceptedTerms()
            let shouldLoad = UserDefaultsService.shared.getShouldLoadGameLibrary()
            if let username = KeychainWrapper.shared.string(forKey: Consts.KeychainKeys.Username) {
                if (shouldLoad) {
                    API(self.library).getGameLibrary(username: username, completion: { library in
                        if (library != nil) {
                            UserDefaultsService.shared.setLoadGameLibrary(false)
                            DispatchQueue.main.async {
                                self.library.library = []
                                self.library.library = library!
                            }
                        }
                    })
                } else {
                    var savedLibrary = CoreDataService.shared.fetchGameLibrary()
                    savedLibrary.sort(by: {$1.name > $0.name })
                    DispatchQueue.main.async {
                        self.library.library = []
                        self.library.library = savedLibrary
                    }
                }
            } else if self.termsAccepted {
                self.promptLogin = true
            }
        })
        .popover(isPresented: self.$promptLogin, content: {
            //TODO: need to style the popover
            VStack {
                TextField("Enter Boardgame Geek Username", text: self.$username)
                Button(action: {
                    AnalysticsService.shared.logButtonClick("Login", pageName: "Home")
                    let shouldLoad = UserDefaultsService.shared.getShouldLoadGameLibrary()
                    if (shouldLoad) {
                        KeychainWrapper.shared.set(self.username, forKey: Consts.KeychainKeys.Username)
                        API(self.library).getGameLibrary(username: self.username, completion: { library in
                            if (library != nil) {
                                UserDefaultsService.shared.setLoadGameLibrary(false)
                                DispatchQueue.main.async {
                                    self.library.library = []
                                    self.library.library = library!
                                }
                            }
                        })
                    }else {
                        var savedLibrary = CoreDataService.shared.fetchGameLibrary()
                        savedLibrary.sort(by: {$1.name > $0.name })
                        DispatchQueue.main.async {
                            self.library.library = []
                            self.library.library = savedLibrary
                        }
                    }
                    self.promptLogin = false
                }) {
                    Text("Login")
                }
                Spacer()
//                    Text("Create Account")
                //TODO: add link to BGG to create Account
            }
            
        })
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        .environmentObject(Library())
    }
}
