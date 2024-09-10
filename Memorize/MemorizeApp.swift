//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Dren Uruqi on 26.8.24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            MatchCardGameView(viewModel: EmojiMemoryGame())
        }
    }
}
