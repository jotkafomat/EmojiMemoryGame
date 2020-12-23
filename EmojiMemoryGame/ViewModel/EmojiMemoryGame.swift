//
//  EmojiMemoryGame.swift
//  EmojiMemoryGame
//
//  Created by Krzysztof Jankowski on 23/12/2020.
//

import SwiftUI

class EmojiMemoryGame {
    
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["😱", "🤬", "💩", "😡", "🤢"]
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 1...emojis.count)) { index in return emojis[index] }
    }
    // MARK - Access too the model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intends
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
