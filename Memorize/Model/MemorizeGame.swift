//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Dren Uruqi on 5.9.24.
//

import Foundation

struct MemorizeGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { return cards.indices.filter { index in cards[index].isFacedUp }.only }
        set { cards.indices.forEach{ cards[$0].isFacedUp = (newValue == $0) } }
    }
    
    mutating func chooseCard(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFacedUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFacedUp = true
            }
        }
    }
    
    mutating func shuffleCard() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFacedUp = false
        var isMatched = false
        let content: CardContent
        var id: String
        var debugDescription: String {
            "id: \(id), content: \(content), isMatched: \(isMatched ? "match" : "noMatch"), isFacedUp: \(isFacedUp ? "up" : "down")"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
