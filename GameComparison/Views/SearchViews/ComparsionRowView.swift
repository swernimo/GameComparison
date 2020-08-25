//
//  ComparsionRowView.swift
//  GameComparison
//
//  Created by Personal on 8/19/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct ComparsionRowView: View {
    @State var sectionName: String
    @State var displayFormat: String = "%.2f"
    @State var gameValue: Double
    @State var libraryAverage: Double
    @State var difference: Double
    @State var goodColor: Color = .green
    @State var badColor: Color = .red
    var body: some View {
        VStack{
            Text("\(self.sectionName)")
                .font(.headline)
            HStack{
                Spacer()
                if (Int(gameValue) == 0){
                    Text("-")
                        .frame(alignment: .leading)
                } else {
                    Text("\(String(format: displayFormat, gameValue))")
                        .frame(alignment: .leading)
                }
                Spacer()
                Text("\(String(format: displayFormat, libraryAverage))")
                Spacer()
                if (Int(gameValue) == Int(libraryAverage) && self.displayFormat == "%0.f") {
                    Image(systemName: "arrow.right.arrow.left").resizable()
                        .frame(width: 15, height: 15, alignment: .center)
                    Spacer()
                } else {
                    Image(systemName: (gameValue > libraryAverage) ? "arrow.up" : "arrow.down")
                        .resizable()
                        .frame(width: 10, height: 10, alignment: .trailing)
                        .foregroundColor((gameValue < libraryAverage) ? self.goodColor : self.badColor)
                    Text("\(String(format: displayFormat, difference))")
                        .foregroundColor((gameValue < libraryAverage) ? self.goodColor : self.badColor)
                        .frame(alignment: .center)
                    Spacer()
                }
            }
        }
        .padding(.top, 15)
    }
}

struct ComparsionRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            ComparsionRowView(sectionName: "Rating", displayFormat: "%0.2f", gameValue: 2.55, libraryAverage: 3.012, difference: 0.732, goodColor: .red, badColor: .green)
            
            ComparsionRowView(sectionName: "Rating", displayFormat: "%0.2f", gameValue: 5.345, libraryAverage: 3.012, difference: 0.732)
            
            ComparsionRowView(sectionName: "Rating", displayFormat: "%0.f", gameValue: 6.45, libraryAverage: 6.32, difference: 0.732)
            
            ComparsionRowView(sectionName: "Rating", displayFormat: "%0.f", gameValue: 0, libraryAverage: 6.32, difference: 0.732)
            
            ComparsionRowView(sectionName: "Complexity", displayFormat: "%0.2f", gameValue: 5.345, libraryAverage: 3.012, difference: 0.732)
        }
    }
}
