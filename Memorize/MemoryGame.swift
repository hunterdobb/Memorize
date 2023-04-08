//
//  MemoryGame.swift
//  Memorize
//
//  Created by Hunter Dobbelmann on 4/7/23.
//

import Foundation

// MARK: Model
struct MemoryGame<CardContent> where CardContent: Equatable {
	private(set) var cards: [Card]
	private(set) var score: Int = 0

	private var indexOfOnlyFaceUpCard: Int?

	init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
		cards = [Card]()
		// add numberOfPairsOfCards * 2 cards to cards array
		for pairIndex in 0..<numberOfPairsOfCards {
			let content = createCardContent(pairIndex)
			cards.append(Card(content: content, id: pairIndex * 2))
			cards.append(Card(content: content, id: pairIndex * 2 + 1))
		}

		cards.shuffle()
	}

	mutating func choose(_ card: Card) {
		if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}),
			!cards[chosenIndex].isFaceUp,
			!cards[chosenIndex].isMatched
		{
			if let potentialMatchIndex = indexOfOnlyFaceUpCard {
				if cards[chosenIndex].content == cards[potentialMatchIndex].content {
					// match
					cards[chosenIndex].isMatched = true
					cards[potentialMatchIndex].isMatched = true

					score += 2
				} else {
					// mismatch
					if cards[chosenIndex].previouslySeen && cards[potentialMatchIndex].previouslySeen {
						score -= 2
					} else if cards[chosenIndex].previouslySeen {
						score -= 1
					} else if cards[potentialMatchIndex].previouslySeen {
						score -= 1
					}

				}
				indexOfOnlyFaceUpCard = nil
			} else {
				// turn all cards face down
				for index in cards.indices { // 'cards.indices' is same as 0..<cards.count
					if cards[index].isFaceUp {
						cards[index].previouslySeen = true
					}
					cards[index].isFaceUp = false
				}

				indexOfOnlyFaceUpCard = chosenIndex
			}

			// Card is flipped
			cards[chosenIndex].isFaceUp.toggle()
		}
	}

	mutating func resetScore() {
		score = 0
	}

	struct Card: Identifiable {
		var isFaceUp = false
		var isMatched = false
		var previouslySeen = false
		var content: CardContent
		var id: Int
	}
}


