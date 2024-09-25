//
//  ContentView.swift
//  Memorize
//
//  Created by Dren Uruqi on 26.8.24.
//

import SwiftUI

struct MatchCardGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Text("Best: %")
                    .font(.headline)
                Text("Memorize")
                    .font(.largeTitle)
                    .foregroundStyle(.teal)
                Text("Current: %")
                    .font(.headline)
                    .padding(.bottom, -3)
            } .padding(.vertical, -5)
            ScrollView {
                cards  .animation(.default, value: viewModel.card)
            }
            HStack(spacing: 50) {
                Button("Switch") {
                    viewModel.newGameCreated()
                }
                Text("Theme")
                    .font(.headline)
                Button("Shuffle") {
                    viewModel.shuffleCards()
                }
            } .padding(.top, 11)
                .padding(.bottom, -15)
        } .padding()
            .onAppear{
                viewModel.shuffleCards()
                EmojiMemoryGame.appendRandomArray()
            }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80), spacing: 0)], spacing: 0) {
            ForEach(viewModel.card) { card in
                CardView(card: card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(3)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
            .foregroundColor(.teal)
        }
    }
}
    
struct CardView: View {
    let card: MemorizeGame<String>.Card
    
    init(card: MemorizeGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let rectangle = RoundedRectangle(cornerRadius: 10)
            Group {
                rectangle.fill(.white)
                rectangle.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.system(size: 100))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            } .opacity(card.isFacedUp ? 1 : 0)
            rectangle.fill()
                .opacity(card.isFacedUp ? 0 : 1)
        }
        .opacity(card.isFacedUp || !card.isMatched ? 1 : 0)
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
