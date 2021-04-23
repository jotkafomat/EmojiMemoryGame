//
//  EmojiMemoryGame.swift
//  EmojiMemoryGame
//
//  Created by Krzysztof Jankowski on 23/12/2020.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {

    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static var theme = Theme.random
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs, cardContentFactory: { index in return theme.contents[index] })
    }
    // MARK - Access too the model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    var score: Int {
        model.score
    }
    
    // MARK: - Intents
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    func newGame() {
        EmojiMemoryGame.theme = Theme.random
        model = EmojiMemoryGame.createMemoryGame()
    }
}


