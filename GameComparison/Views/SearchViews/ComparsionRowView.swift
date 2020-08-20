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
    var body: some View {
        VStack{
            Text("\(self.sectionName)")
            HStack{
                Spacer()
                Text("\(String(format: displayFormat, gameValue))")
                    .frame(alignment: .leading)
                Spacer()
                Text("\(String(format: displayFormat, libraryAverage))")
                Spacer()
                Image(systemName: (gameValue > libraryAverage) ? "arrow.up" : "arrow.down")
                    .resizable()
                    .frame(width: 10, height: 10, alignment: .trailing)
                    .foregroundColor((gameValue > libraryAverage) ? .green : .red)
                Text("\(String(format: displayFormat, difference))")
                    .foregroundColor((gameValue > libraryAverage) ? .green : .red)
                    .frame(alignment: .center)
                Spacer()
            }
        }
    }
}

struct ComparsionRowView_Previews: PreviewProvider {
    static var previews: some View {
        ComparsionRowView(sectionName: "Rating", displayFormat: "%0.2f", gameValue: 2.55, libraryAverage: 3.012, difference: 0.732)
    }
}
