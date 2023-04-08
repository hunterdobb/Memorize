//
//  ContentView.swift
//  Memorize
//
//  Created by Hunter Dobbelmann on 4/7/23.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var emojiGame: EmojiMemoryGame // <-- ViewModel

	var body: some View {
		NavigationStack {
			VStack {
				ScrollView {
					LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))], spacing: 8) {
						ForEach(emojiGame.cards) { card in
							CardView(card: card)
								.aspectRatio(2/3, contentMode: .fit)
								.onTapGesture {
									emojiGame.choose(card)
								}
						}
					}
					.padding(.top)
				}
				.navigationTitle(emojiGame.themeName)
				.navigationBarTitleDisplayMode(.inline)
				.foregroundStyle(emojiGame.themeColor)
				.padding(.horizontal)
				.toolbar {
					ToolbarItem {
						Button("New Game") {
							emojiGame.newGame()
						}
					}
				}

				Text("Score: \(emojiGame.score)")
					.font(.largeTitle)
					.fontWeight(.heavy)
					.monospaced()
			}
		}
	}
}

struct CardView: View {
	let card: MemoryGame<String>.Card

	var body: some View {
		ZStack {
			let shape = RoundedRectangle(cornerRadius: 20)

			if card.isFaceUp {
				shape.fill().foregroundColor(.white)
				shape.strokeBorder(lineWidth: 3)
				Text(card.content).font(.largeTitle)
			} else if card.isMatched {
				shape.opacity(0)
			} else {
				shape.fill()
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		let game = EmojiMemoryGame()
        ContentView(emojiGame: game)
    }
}
