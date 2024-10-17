//
//  CardView.swift
//  Memorize
//
//  Created by Dren Uruqi on 2.10.24.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemorizeGame<String>.Card
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor: CGFloat = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 0.5
            static let pieInset: CGFloat = 5
        }
    }
    
    var body: some View {
        TimelineView(.animation) { timeline in
            if card.isFacedUp || !card.isMatched {
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                    .opacity(Constants.Pie.opacity)
                    .overlay(cardContent.padding(Constants.Pie.pieInset))
                    .padding(Constants.inset)
                    .cardify(isFacedUp: card.isFacedUp)
                    .transition(.scale)
            } else {
                Color.clear
            }
        }
    }
    
    var cardContent: some View {
        Text(card.content)
            .font(.system(size: Constants.FontSize.largest))
            .minimumScaleFactor(Constants.FontSize.scaleFactor)
            .multilineTextAlignment(.center)
            .aspectRatio(1, contentMode: .fit)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.spin(duration: 1), value: card.isMatched)
    }
}

extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: 1).repeatForever(autoreverses: false)
    }
}

#Preview {
//    typealias card = MemorizeGame<String>.Card
    VStack {
        HStack {
            CardView(CardView.Card(isFacedUp: true, content: "X", id: "test1"))
            CardView(CardView.Card(content: "X", id: "test1"))
        }
        HStack {
            CardView(CardView.Card(isFacedUp: true, content: "This is a very long String and i hope it fits the Card", id: "test1"))
            CardView(CardView.Card(isMatched: true, content: "X", id: "test1"))
        }
    }
        .foregroundStyle(.green)
        .padding()
}
