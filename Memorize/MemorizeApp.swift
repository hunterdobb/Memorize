//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Hunter Dobbelmann on 4/7/23.
//

import SwiftUI

@main
struct MemorizeApp: App {
	let emojiGame = EmojiMemoryGame()

    var body: some Scene {
        WindowGroup {
            ContentView(emojiGame: emojiGame)
        }
    }
}
