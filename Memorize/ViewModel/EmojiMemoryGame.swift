//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Dren Uruqi on 5.9.24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    var model = createMemoryGame()
    typealias Card = MemorizeGame<String>.Card
    private static let carnivoreEmojis = ["🦊", "🦁", "🐻", "🐉", "🐅", "🐊", "🦅", "🐺", "🦖", "🦇"]
    private static let herbivoreEmojis = ["🐨", "🐒", "🪿", "🐢", "🦍", "🐄", "🦒", "🦆", "🦕", "🦘"]
    private static let seaEmojis = ["🦈", "🐋", "🦭", "🐙", "🦑", "🪼", "🦀", "🐬", "🦞", "🐟"]
    private static let faceEmojis = ["😀", "🤑", "🤣", "🤢", "🤯", "😡", "🥶", "😱", "🫥", "🫨"]
    private static let symbolsEmojis = ["☯️", "☣️", "☮️", "⚛️", "✴️", "🔯", "🪯", "☢️", "☸️", "❇️"]
    private static let spaceEmojis = ["🌚", "⭐️", "🌍", "⚡️", "☀️", "❄️", "💧", "🪐", "🌙", "🌕"]
    private static var arrayForUse: [String] = []
    private static var themeSetterVar = ""
    
    static func appendRandomArray() {
        arrayForUse.removeAll()
        let allEmojiArrays = [carnivoreEmojis, herbivoreEmojis, seaEmojis, faceEmojis, symbolsEmojis, spaceEmojis]
        
        if let randomEmojis = allEmojiArrays.randomElement() {
            arrayForUse.append(contentsOf: randomEmojis.shuffled())
            themeSetterVar.append(randomEmojis[0])
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
    
    func themeSetter() -> (String, Color) {
        if EmojiMemoryGame.themeSetterVar.count > 1 {
            EmojiMemoryGame.themeSetterVar = String(EmojiMemoryGame.themeSetterVar.dropFirst())
        }
        
        switch EmojiMemoryGame.themeSetterVar {
        case "🦊":
            return ("Carnivore", .red)
        case "🐨":
            return ("Herbivore", .green)
        case "🦈":
            return ("Sea", .blue)
        case "😀":
            return ("Emojis", .orange)
        case "☯️":
            return ("Symbol", .purple)
        case "🌚":
            return ("Space", .teal)
        default:
            return ("Unknown", .brown)
        }
    }

    
    @Published private var gameModel = createMemoryGame()

    var card: Array<Card> {
        return gameModel.cards
    }
    
    var currentScore: Int {
        gameModel.currentScore
    }
    
    var bestScore: Int {
        gameModel.bestScore
    }
    
    // MARK: - Users Intent
    
    func shuffleCards() {
        gameModel.shuffleCard()
    }
    
    func choose(_ card: Card) {
        gameModel.chooseCard(card)
    }
    
    func newGameCreated() {
        gameModel = EmojiMemoryGame.createMemoryGame()
        shuffleCards()
    }
}
