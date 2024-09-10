//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Dren Uruqi on 5.9.24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["🌚", "⭐️", "🌍", "⚡️", "☀️", "❄️", "💧", "🪐", "🌙", "🌕"]
    private static func createMemoryGame() -> MemorizeGame<String> {
        return MemorizeGame(numberOfPairsOfCards: 10) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    @Published private var gameModel = createMemoryGame()

    var card: Array<MemorizeGame<String>.Card> {
        return gameModel.cards
    }
    
    // MARK: - Users Intent
    
    func shuffleCards() {
        gameModel.shuffleCard()
    }
    
    func choose(_ card: MemorizeGame<String>.Card) {
        gameModel.chooseCard(card)
    }
}
