//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Dren Uruqi on 5.9.24.
//

import Foundation

struct MemorizeGame<CardContent> {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func chooseCard(_ card: Card) {
//        card.isFacedUp.toggle()
    }
    
    mutating func shuffleCard() {
        cards.shuffle()
    }
    
    struct Card {
        var isFacedUp = false
        var isMatched = false
        let content: CardContent
    }
}
