//
//  TermsOfUseView.swift
//  GameComparison
//
//  Created by Personal on 9/12/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct TermsOfUseView: View {
    @EnvironmentObject var library: Library
    @State private var showAlert = false
    @State private var terms: String = ""
    private func loadTermsOfUse() {
        let savedTerms = Consts.TermsOfUse.loadTerms()
        self.terms = (savedTerms != nil) ? savedTerms! : "Problem getting terms"
    }
    
    var body: some View {
        GeometryReader { geo in
        NavigationView {
            VStack{
                ScrollView{
                   Text(terms)
                }.frame(width: (geo.size.width * 0.9))
                HStack{
                        Spacer()
                        Button(action: {
                            AnalysticsService.shared.logButtonClick("Decline", pageName: "Terms of Use")
                            self.showAlert = true
                            UserDefaultsService.shared.setTermsAccepted(false)
                            KeychainWrapper.shared.removeObject(forKey: Consts.KeychainKeys.Username)
                            CoreDataService.shared.deleteAllData()
                        }){
                            Text("Decline")
                        }
                        Spacer()
//                        Button(action: {
//                            AnalysticsService.shared.logButtonClick("Accept", pageName: "Terms of Use")
//                            UserDefaultsService.shared.setTermsAccepted(true)
//                        }, label: {
//                            Text("Accept")
//                        })
                        NavigationLink (destination: CDSideMenuMainView()
                                            .environmentObject(self.library)
                                                .environmentObject(MenuHelper.shared.createConfiguration())
                                                .navigationBarHidden(true)
                                                .navigationBarTitle("")){
                            Text("Accept")
                        }.simultaneousGesture(TapGesture().onEnded {
                            AnalysticsService.shared.logButtonClick("Accept", pageName: "Terms of Use")
                            UserDefaultsService.shared.setTermsAccepted(true)
                        })
                        .navigationBarBackButtonHidden(true)
                        Spacer()
                    }
                }
        } .navigationBarHidden(true)
        }.alert(isPresented: self.$showAlert, content: {
            Alert(title: Text("Terms of Use"), message: Text("You must accept terms of use to use the app"), dismissButton: .cancel(Text("Okay")))
        })
        .onAppear(perform: {
            AnalysticsService.shared.logPageView("Terms of Use")
            loadTermsOfUse()
        })
    }
}

struct TermsOfUseView_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfUseView()
    }
}
