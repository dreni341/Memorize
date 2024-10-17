//
//  ContentView.swift
//  Memorize
//
//  Created by Dren Uruqi on 26.8.24.
//

import SwiftUI

struct MatchCardGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    typealias Card = MemorizeGame<String>.Card
    let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Text("Best: \(viewModel.bestScore)")
                    .font(.headline)
                Text("Memorize")
                    .font(.largeTitle)
                    .foregroundStyle(.black)
                    .padding(.leading, 7)
                Text("Current: \(viewModel.currentScore)")
                    .font(.headline)
                    .padding(.bottom, -3)
            } .padding(.vertical, -5)
            cards
            //                .animation(.bouncy, value: viewModel.card)
                .foregroundColor(viewModel.themeSetter().1)
            HStack(spacing: 20) {
                deck
                    .padding(.bottom, -6)
                Button("Switch") {
                    withAnimation(.bouncy) {
                        viewModel.newGameCreated()
                    }
                } .frame(width: 70, height: 30)
                    .foregroundColor(.white)
                    .background(viewModel.themeSetter().1)
                    .cornerRadius(10)
                Text(viewModel.themeSetter().0)
                    .foregroundColor(viewModel.themeSetter().1)
                    .font(.headline)
                Button("Shuffle") {
                    withAnimation(.bouncy) {
                        viewModel.shuffleCards()
                    }
                } .frame(width: 70, height: 30)
                    .foregroundColor(.white)
                    .background(viewModel.themeSetter().1)
                    .cornerRadius(10)
                discardPile
                    .padding(.bottom, -6)
            } .padding(.top, 15)
                .padding(.bottom, -15)
        } .padding()
            .onAppear{
                viewModel.shuffleCards()
                EmojiMemoryGame.appendRandomArray()
            }
    }
    
    private var cards: some View {
        AspectVGrid(items: viewModel.card, aspectRatio: aspectRatio) { card in
            if isDealt(card) {
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .matchedGeometryEffect(id: card.id, in: pilingNameSpace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(3)
                    .overlay{FlyingNumber(number: scoreChanged(causedBy: card))}
                    .zIndex(scoreChanged(causedBy: card) != 0 ? 1 : 0)
                    .onTapGesture {
                        choose(card)
                    }
            }
        }
    }
    
    private func choose(_ card: Card) {
        withAnimation(.easeInOut(duration: 0.6)) {
            let scoreBeforeChoosing = viewModel.currentScore
            viewModel.choose(card)
            let scoreAfterChoosing = viewModel.currentScore - scoreBeforeChoosing
            lastScoreChange = (scoreAfterChoosing, causedByCardId: card.id)
        }
    }
    
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var unDealtCards: [Card] {
        viewModel.card.filter{ !isDealt($0) }
    }
    
    private let deckWidth: CGFloat = 30
    private let dealInterval: TimeInterval = 0.10
    private let dealAnimation: Animation = .interactiveSpring(duration: 0.7)
    @State var piledCards: Array<Card> = []
    @Namespace private var dealingNameSpace
    @Namespace private var pilingNameSpace
    
    private var deck: some View {
        ZStack {
            ForEach(unDealtCards) { card in
                CardView(card)
                    .offset(x: .random(in: -3...3), y: .random(in: -3...3))
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
        .foregroundStyle(viewModel.themeSetter().1)
        .onTapGesture {
            deal()
        }
    }
    
    private func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.card {
            withAnimation(dealAnimation.delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += dealInterval
        }
    }
    
    private func updatePiledCards() {
        withAnimation(dealAnimation) {
            piledCards = viewModel.cardToPile
        }
    }
    
    private var discardPile: some View {
        return ZStack {
                ForEach(piledCards) { card in
                    CardView(card)
                        .offset(x: .random(in: -3...3), y: .random(in: -3...3))
                        .matchedGeometryEffect(id: card.id, in: pilingNameSpace)
                        .transition(.asymmetric(insertion: .identity, removal: .identity))
                        .animation(.easeInOut, value: piledCards)
                }
                .frame(width: deckWidth, height: deckWidth / aspectRatio)
                .foregroundStyle(viewModel.themeSetter().1)
        }
        .onChange(of: viewModel.cardToPile) { _ in
            updatePiledCards()
        }
    }
    
    @State private var lastScoreChange = (0, causedByCardId: "")
    
    private func scoreChanged(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
}



struct MatchCardGameView_Previews: PreviewProvider {
    static var previews: some View {
        MatchCardGameView(viewModel: EmojiMemoryGame())
    }
}


//let carnivoreEmojis = ["🦊", "🦁", "🐻", "🐉", "🐅", "🐊", "🦅", "🐺", "🦈", "🦖", "🐦‍⬛", "🦇", "🦊", "🦁", "🐻", "🐉", "🐅", "🐊", "🦅", "🐺", "🦈", "🦖", "🐦‍⬛", "🦇"]
//let herbivoreEmojis = ["🐨", "🐒", "🪿", "🐢", "🦍", "🐄", "🦒", "🦆", "🦋", "🦕", "🦘", "🦏", "🐨", "🐒", "🪿", "🐢", "🦍", "🐄", "🦒", "🦆", "🦋", "🦕", "🦘", "🦏"]
//let seaEmojis = ["🦈", "🐋", "🦭", "🐙", "🦑", "🪼", "🦀", "🦩", "🐬", "🦞", "🐟", "🐡", "🦈", "🐋", "🦭", "🐙", "🦑", "🪼", "🦀", "🦩", "🐬", "🦞", "🐟", "🐡"]
//@State var currentEmojiArray: [String] = []
//@State var firstThemeClicked = false
//@State var secondThemeClicked = false
//@State var thirdThemeClicked = false
//    var cardAdjusters: some View {
//        HStack {
//            cardRemover
//            Spacer()
//            themeChoosing .padding(.leading, -9)
//            Spacer()
//            cardAdder
//        } .imageScale(.large)
//    }
//
//    func cardAdjusterFunc(by offset: Int, symbol: String) -> some View {
//        Button {
//            cardCount += offset
//        } label: {
//            Image(systemName: symbol)
//        }
//        .disabled(cardCount + offset < 1 || cardCount + offset > carnivoreEmojis.count)
//    }
//
//    func themeChoosing(themeChosen: Array<String>) {
//        currentEmojiArray = themeChosen
//    }
//
//    var themeChoosing: some View {
//        HStack(spacing: 30) {
//            firstTheme
//            secondTheme
//            thirdTheme
//        } .imageScale(.large)
//    }
//
//    var cardAdder: some View {
//        cardAdjusterFunc(by: +1, symbol: "rectangle.stack.badge.plus.fill")
//    }
//    var cardRemover: some View {
//        cardAdjusterFunc(by: -1, symbol: "rectangle.stack.badge.minus.fill")
//    }
//    var firstTheme: some View {
//        VStack {
//            if firstThemeClicked {
//                Image(systemName: "pawprint.circle")
//            } else {
//                Image(systemName: "questionmark.circle")
//            }
//            Text("Carnivore")
//                .font(.footnote)
//        } .onTapGesture {
//            themeChoosing(themeChosen: carnivoreEmojis.shuffled())
//            firstThemeClicked = true
//            secondThemeClicked = false
//            thirdThemeClicked = false
//        }
//        .foregroundColor(.red)
//    }
//    var secondTheme: some View {
//        VStack {
//            if secondThemeClicked {
//                Image(systemName: "tree.circle")
//            } else {
//                Image(systemName: "questionmark.circle")
//            }
//            Text("Herbivore")
//                .font(.footnote)
//        }.onTapGesture {
//            themeChoosing(themeChosen: herbivoreEmojis.shuffled())
//            firstThemeClicked = false
//            secondThemeClicked = true
//            thirdThemeClicked = false
//        }
//        .foregroundColor(.green)
//    }
//    var thirdTheme: some View {
//        VStack {
//            if thirdThemeClicked {
//                Image(systemName: "water.waves")
//            } else {
//                Image(systemName: "questionmark.circle")
//            }
//            Text("Sea")
//                .font(.footnote)
//        }.onTapGesture {
//            themeChoosing(themeChosen: seaEmojis.shuffled())
//            firstThemeClicked = false
//            secondThemeClicked = false
//            thirdThemeClicked = true
//        }
//        .foregroundColor(.blue)
//    }
//}
