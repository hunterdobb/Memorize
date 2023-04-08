//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Hunter Dobbelmann on 4/7/23.
//

import SwiftUI

/* Extra Transport Emojis
"🚀", "⛵️", "🛸", "🛶", "🚌", "🏍️", "🛺", "🚠", "🛵", "🚗",
"🚚", "🚇", "🛻", "🚝"
 */

// MARK: ViewModel for ContentView
class EmojiMemoryGame: ObservableObject {
	static let transportEmojis 	= ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎️", "🚑", "🚓", "🚒", "✈️"]
	static let peopleEmojis 	= ["🧑‍✈️", "👩‍🚀", "👩‍🏫", "👩‍🎤", "🧑🏽‍🍳", "👩‍🌾", "🕵️‍♀️", "💂‍♂️", "🧕", "👮‍♀️"]
	static let facesEmojis 		= ["😀", "😉", "☺️", "😝", "😟", "🥳", "🧐", "🤬", "😭", "🤯"]
	static let flagsEmojis 		= ["🏳️‍🌈", "🏳️‍⚧️", "🇦🇮", "🇯🇵", "🇲🇺", "🇲🇱", "🇮🇩", "🇬🇬", "🇬🇷", "🇪🇺"]
	static let loveEmojis 		= ["❤️", "😘", "😍", "💌", "💝", "🫶🏼", "❤️‍🩹", "❤️‍🔥", "🩵", "💔"]
	static let scaryEmojis 		= ["👻", "👹", "🎃", "😈", "💀", "☠️", "🪦", "⚰️"]

	static let themes: [EmojiMemoryGameTheme] = [
		EmojiMemoryGameTheme(name: "Transportation", emojis: transportEmojis, color: .blue),
		EmojiMemoryGameTheme(name: "People", emojis: peopleEmojis, numberOfPairsOfCards: 4, color: .purple),
		EmojiMemoryGameTheme(name: "Faces", emojis: facesEmojis, numberOfPairsOfCards: 4, color: .yellow),
		EmojiMemoryGameTheme(name: "Flags", emojis: flagsEmojis, numberOfPairsOfCards: 4, color: .green),
		EmojiMemoryGameTheme(name: "Love", emojis: loveEmojis, numberOfPairsOfCards: 4, color: .red),
		EmojiMemoryGameTheme(name: "Scary", emojis: scaryEmojis, numberOfPairsOfCards: 4, color: .orange),
	]

	@Published private var currentTheme: EmojiMemoryGameTheme

	/// The model used to play a memory game
	@Published private var model: MemoryGame<String>


	init() {
		let randomTheme = EmojiMemoryGame.themes.randomElement() ?? EmojiMemoryGame.themes[0]
		currentTheme = randomTheme
		self.model = EmojiMemoryGame.createMemoryGame(theme: randomTheme)
	}

	/// Creates a memory game model with CardContent type of String
	static func createMemoryGame(theme: EmojiMemoryGameTheme) -> MemoryGame<String> {
		let shuffledEmojis = theme.emojis.shuffled()

		return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in
			shuffledEmojis[pairIndex]
		}
	}

	/// Access the cards from the model
	var cards: [MemoryGame<String>.Card] {
		model.cards
	}

	var score: Int {
		model.score
	}

	var themeColor: Color {
		switch currentTheme.color {
		case .blue:
			return .blue
		case .purple:
			return .purple
		case .yellow:
			return .yellow
		case .green:
			return .green
		case .red:
			return .red
		case .orange:
			return .orange
		}
	}

	var themeName: String {
		currentTheme.name
	}

	// MARK: - Intent(s)
	/// Calls the models choose method
	func choose(_ card: MemoryGame<String>.Card) {
		model.choose(card)
	}

	/// Randomly picks a theme and starts a new game
	func newGame() {
		let randomTheme = EmojiMemoryGame.themes.randomElement() ?? EmojiMemoryGame.themes[0]
		currentTheme = randomTheme
		model.resetScore()
		self.model = EmojiMemoryGame.createMemoryGame(theme: randomTheme)
	}
}


