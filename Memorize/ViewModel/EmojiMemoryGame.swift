//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Dren Uruqi on 5.9.24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let carnivoreEmojis = ["🦊", "🦁", "🐻", "🐉", "🐅", "🐊", "🦅", "🐺", "🦖", "🦇"]
    private static let herbivoreEmojis = ["🐨", "🐒", "🪿", "🐢", "🦍", "🐄", "🦒", "🦆", "🦕", "🦘"]
    private static let seaEmojis = ["🦈", "🐋", "🦭", "🐙", "🦑", "🪼", "🦀", "🐬", "🦞", "🐟"]
    private static let faceEmojis = ["😀", "🤑", "🤣", "🤢", "🤯", "😡", "🥶", "😱", "🫥", "🫨"]
    private static let symbolsEmojis = ["☯️", "☣️", "☮️", "⚛️", "✴️", "🔯", "🪯", "☢️", "☸️", "❇️"]
    private static let spaceEmojis = ["🌚", "⭐️", "🌍", "⚡️", "☀️", "❄️", "💧", "🪐", "🌙", "🌕"]
    private static var arrayForUse: [String] = []
    
    static func appendRandomArray() {
        arrayForUse.removeAll()
        let allEmojiArrays = [carnivoreEmojis, herbivoreEmojis, seaEmojis, faceEmojis, symbolsEmojis, spaceEmojis]
        
        if let randomEmojis = allEmojiArrays.randomElement() {
            arrayForUse.append(contentsOf: randomEmojis.shuffled())
        }
    }
    
    private static func createMemoryGame() -> MemorizeGame<String> {
        appendRandomArray()
        return MemorizeGame(numberOfPairsOfCards: 10) { pairIndex in
            if arrayForUse.indices.contains(pairIndex) {
                return arrayForUse[pairIndex]
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
    
    func newGameCreated() {
        gameModel = EmojiMemoryGame.createMemoryGame()
        shuffleCards()
    }
}
