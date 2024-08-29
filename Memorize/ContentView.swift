//
//  ContentView.swift
//  Memorize
//
//  Created by Dren Uruqi on 26.8.24.
//

import SwiftUI

struct ContentView: View {
    let carnivoreEmojis = ["🦊", "🦁", "🐻", "🐉", "🐅", "🐊", "🦅", "🦊", "🦁", "🐻", "🐉", "🐅", "🐊", "🦅"]
    let herbivoreEmojis = ["🐨", "🐒", "🪿", "🐢", "🦍", "🐄", "🦒", "🐨", "🐒", "🪿", "🐢", "🦍", "🐄", "🦒"]
    let seaEmojis = ["🦈", "🐋", "🦭", "🐙", "🦑", "🪼", "🦀", "🦈", "🐋", "🦭", "🐙", "🦑", "🪼", "🦀"]
    @State var currentEmojiArray: [String] = []
    @State var firstThemeClicked = false
    @State var secondThemeClicked = false
    @State var thirdThemeClicked = false
    @State var cardCount = 10
    
    var body: some View {
        VStack {
            Text("Memorize")
                .font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            cardAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            if currentEmojiArray != [] {
                ForEach(0..<cardCount, id: \.self) { index in
                    CardView(content: currentEmojiArray[index])
                        .aspectRatio(2/3, contentMode: .fit)
                }
                .foregroundColor(firstThemeClicked ? .red : secondThemeClicked ? .green : thirdThemeClicked ? .blue : .black)
            }
        }
    }
    
    var cardAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            themeChoosing .padding(.leading, -6)
            Spacer()
            cardAdder
        } .imageScale(.large)
    }
    
    func cardAdjusterFunc(by offset: Int, symbol: String) -> some View {
        Button {
            cardCount += offset
        } label: {
            Image(systemName: symbol)
        }
        .disabled(cardCount + offset < 1 || cardCount + offset > carnivoreEmojis.count)
    }
    
    func themeChoosing(themeChosen: Array<String>) {
        currentEmojiArray = themeChosen
    }
    
    var themeChoosing: some View {
        HStack(spacing: 30) {
            firstTheme
            secondTheme
            thirdTheme
        } .imageScale(.large)
    }
    
    var cardAdder: some View {
        cardAdjusterFunc(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
    var cardRemover: some View {
        cardAdjusterFunc(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    var firstTheme: some View {
        VStack {
            if firstThemeClicked {
                Image(systemName: "pawprint.circle")
            } else {
                Image(systemName: "questionmark.circle")
            }
            Text("Carnivore")
                .font(.footnote)
        } .onTapGesture {
            themeChoosing(themeChosen: carnivoreEmojis)
            firstThemeClicked = true
            secondThemeClicked = false
            thirdThemeClicked = false
        }
        .foregroundColor(.red)
    }
    var secondTheme: some View {
        VStack {
            if secondThemeClicked {
                Image(systemName: "tree.circle")
            } else {
                Image(systemName: "questionmark.circle")
            }
            Text("Herbivore")
                .font(.footnote)
        }.onTapGesture {
            themeChoosing(themeChosen: herbivoreEmojis)
            firstThemeClicked = false
            secondThemeClicked = true
            thirdThemeClicked = false
        }
        .foregroundColor(.green)
    }
    var thirdTheme: some View {
        VStack {
            if thirdThemeClicked {
                Image(systemName: "water.waves")
            } else {
                Image(systemName: "questionmark.circle")
            }
            Text("Sea")
                .font(.footnote)
        }.onTapGesture {
            themeChoosing(themeChosen: seaEmojis)
            firstThemeClicked = false
            secondThemeClicked = false
            thirdThemeClicked = true
        }
        .foregroundColor(.blue)
    }
}

struct CardView: View {
    let content: String
    @State var isFacedUp = false
    
    var body: some View {
        ZStack {
            let card = RoundedRectangle(cornerRadius: 10)
            Group {
                card.fill(.white)
                card.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } .opacity(isFacedUp ? 1 : 0)
            card.fill().opacity(isFacedUp ? 0 : 1)
        }
        .onTapGesture {
            isFacedUp.toggle()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
