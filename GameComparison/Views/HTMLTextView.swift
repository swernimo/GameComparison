//
//  HTMLTextView.swift
//  GameComparison
//
//  Created by Personal on 9/9/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import SwiftUI

struct HTMLTextView: UIViewRepresentable {
    func updateUIView(_ uiView: UILabel, context: Context) {
        DispatchQueue.main.async {
        let data = Data(self.html.utf8)
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                uiView.attributedText = attributedString
            }
        }
    }

   let html: String
   func makeUIView(context: UIViewRepresentableContext<Self>) -> UILabel {
      let label = UILabel()
      DispatchQueue.main.async {
         let data = Data(self.html.utf8)
         if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            label.attributedText = attributedString
         }
    }

        return label
    }
}

struct HTMLTextView_Previews: PreviewProvider {
    static var previews: some View {
        HTMLTextView(html: "")
    }
}
