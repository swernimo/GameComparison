import WebKit
import SwiftUI

struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        //https://stackoverflow.com/questions/45998220/the-font-looks-like-smaller-in-wkwebview-than-in-uiwebview
        let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"
        uiView.loadHTMLString(htmlContent + headerString, baseURL: nil)
    }
}

struct HTMLView_Previews: PreviewProvider {
    static var previews: some View {
        HTMLStringView(htmlContent: "Inspired by a love of classic video games, Boss Monster: The Dungeon Building Card Game pits 2-4 players in a competition to build the ultimate side-scrolling dungeon. Players compete to lure and destroy hapless adventurers, racing to outbid one another to see who can build the most enticing, treasure-filled dungeon. The goal of Boss Monster is to be the first Boss to amass ten Souls, which are gained when a Hero is lured and defeated &mdash; but a player can lose if his Boss takes five Wounds from Heroes who survive his dungeon.<br/><br/>Playing Boss Monster requires you to juggle two competing priorities: the need to lure Heroes at a faster rate than your opponents, and the need to kill those Heroes before they reach your Boss. Players can build one room per turn, each with its own damage and treasure value. More attractive rooms tend to deal less damage, so a Boss who is too greedy can become inundated with deadly Heroes.<br/><br/>Players interact with each other by building rooms and playing Spells. Because different Heroes seek different treasure types, and rooms are built simultaneously (played face down, then revealed), this means that every &quot;build phase&quot; is a bidding war. Spells are instant-speed effects that can give players advantages or disrupt opponents.<br/><br/>As a standalone card game with 155 cards, Boss Monster contains everything that 2-4 players need to play.<br/><br/>")
    }
}
