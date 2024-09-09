//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Dren Uruqi on 5.9.24.
//

import Foundation

struct MemorizeGame<CardContent> {
    var cards: Array<Card>
    
    func chooseCard(card: Card) {
        
    }
    
    struct Card {
        var isFacedUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
