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
    
    init(card: MemorizeGame<String>.Card) {
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
        Pie(endAngle: .degrees(240))
            .opacity(Constants.Pie.opacity)
            .overlay {
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .padding(Constants.Pie.pieInset)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                    .animation(.spin(duration: 1), value: card.isMatched)
            } .padding(Constants.inset)
            .cardify(isFacedUp: card.isFacedUp)
        .opacity(card.isFacedUp || !card.isMatched ? 1 : 0)
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
            CardView(card: CardView.Card(isFacedUp: true, content: "X", id: "test1"))
            CardView(card: CardView.Card(content: "X", id: "test1"))
        }
        HStack {
            CardView(card: CardView.Card(isFacedUp: true, content: "This is a very long String and i hope it fits the Card", id: "test1"))
            CardView(card: CardView.Card(isMatched: true, content: "X", id: "test1"))
        }
    }
        .foregroundStyle(.green)
        .padding()
}
