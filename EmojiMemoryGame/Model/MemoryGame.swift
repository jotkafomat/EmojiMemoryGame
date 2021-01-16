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
        // check if there is already a card face up
        if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
            //check if it matches the card chosen now
            if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                //mark them both as matched
                cards[chosenIndex].isMatched = true
                cards[potentialMatchIndex].isMatched = true
                // award the user with points
                score += 2
            } else {
                // if cards dont match
                // and were previously flipped penalise user
                if cards[chosenIndex].wasFlipped == true  {
                    score -= 1
                }
                if cards[potentialMatchIndex].wasFlipped == true {
                    score -= 1
                }
                //mark both cards as flipped previously
                cards[chosenIndex].wasFlipped = true
                cards[potentialMatchIndex].wasFlipped = true
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
        var wasFlipped: Bool = false
    }
}
