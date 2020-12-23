//
//  EmojiMemoryGameApp.swift
//  EmojiMemoryGame
//
//  Created by Krzysztof Jankowski on 23/12/2020.
//

import SwiftUI

@main
struct EmojiMemoryGameApp: App {
    
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
