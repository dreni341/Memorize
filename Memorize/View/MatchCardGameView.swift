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
            HStack(spacing: 50) {
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
            } .padding(.top, 11)
                .padding(.bottom, -15)
        } .padding()
            .onAppear{
                viewModel.shuffleCards()
                EmojiMemoryGame.appendRandomArray()
            }
    }
    
    var cards: some View {
        AspectVGrid(items: viewModel.card, aspectRatio: aspectRatio) { card in
            CardView(card: card)
                .padding(3)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.6)) {
                        viewModel.choose(card)
                    }
                }
        }
    }
    
    private func scoreChanged(causedBy card: Card) -> Int {
        return 0
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
