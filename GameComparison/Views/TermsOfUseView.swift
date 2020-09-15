//
//  TermsOfUseView.swift
//  GameComparison
//
//  Created by Personal on 9/12/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct TermsOfUseView: View {
    //TODO: Get actual TOS
    @EnvironmentObject var library: Library
    var body: some View {
        GeometryReader { geo in
        NavigationView{
            VStack{
                ScrollView{
                   Text("This is my Terms of Use Page")
                }.frame(width: (geo.size.width * 0.9))
                HStack{
                        Spacer()
                        Button(action: {
                            print("Decline terms of use")
                            //TODO: How to handle declining TOS?
                            UserDefaultsService.shared.setTermsAccepted(false)
                            KeychainWrapper.shared.removeObject(forKey: Consts.KeychainKeys.Username)
                            CoreDataService.shared.deleteAllData()
                        }){
                            Text("Decline")
                        }
                        Spacer()
                        NavigationLink (destination: ContentView()){
                            Text("Accept")
                        }.simultaneousGesture(TapGesture().onEnded {
                            UserDefaultsService.shared.setTermsAccepted(true)
                        })
                        .navigationBarBackButtonHidden(true)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct TermsOfUseView_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfUseView()
    }
}
