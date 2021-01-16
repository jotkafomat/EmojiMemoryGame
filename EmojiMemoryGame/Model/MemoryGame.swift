//
//  MemoryGame.swift
//  EmojiMemoryGame
//
//  Created by Krzysztof Jankowski on 23/12/2020.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private (set) var cards: Array<Card>
    private (set) var score: Int = 0
    private (set) var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        
        cards = Array<Card>()
        
        for index in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(index)
            cards.append(Card(id: index*2, content: content))
            cards.append(Card(id: index*2+1, content: content))
        }
        cards.shuffle()
    }
    
    mutating func choose(card: Card) {
        guard let chosenIndex: Int = cards.firstIndex(matching: card),
              !cards[chosenIndex].isFaceUp,
              !cards[chosenIndex].isMatched  else {
            return
        }
        
        if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
            if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                cards[chosenIndex].isMatched = true
                cards[potentialMatchIndex].isMatched = true
                score += 2
            }
            self.cards[chosenIndex].isFaceUp = true
        } else {
            indexOfTheOneAndOnlyFaceUpCard = chosenIndex
        }
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
