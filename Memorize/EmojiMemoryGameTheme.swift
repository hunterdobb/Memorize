//
//  EmojiMemoryGameTheme.swift
//  Memorize
//
//  Created by Hunter Dobbelmann on 4/7/23.
//

import Foundation

struct EmojiMemoryGameTheme {
	var name: String
	var emojis: [String]
	var numberOfPairsOfCards: Int
	var color: ThemeColor

	init(name: String, emojis: [String], numberOfPairsOfCards: Int? = nil, color: ThemeColor) {
		self.name = name
		self.emojis = emojis

		if let numberOfPairsOfCards {
			if numberOfPairsOfCards > emojis.count {
				self.numberOfPairsOfCards = emojis.count
			} else {
				self.numberOfPairsOfCards = numberOfPairsOfCards
			}
		} else {
			self.numberOfPairsOfCards = emojis.count
		}
		
		self.color = color
	}

	enum ThemeColor {
		case blue 	// transport
		case purple // people
		case yellow // faces
		case green 	// flags
		case red 	// love
		case orange // scary
	}
}
