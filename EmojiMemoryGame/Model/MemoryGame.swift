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
            cards
                .indices
                .filter { cards[$0].isFaceUp }
                .only
        }
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
        guard let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard else {
            indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            return
        }
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
            if cards[chosenIndex].wasFlipped {
                score -= 1
            }
            if cards[potentialMatchIndex].wasFlipped {
                score -= 1
            }
            //mark both cards as flipped previously
            cards[chosenIndex].wasFlipped = true
            cards[potentialMatchIndex].wasFlipped = true
        }
        self.cards[chosenIndex].isFaceUp = true
        
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        var wasFlipped: Bool = false
        
        var bonusTimeLimit: TimeInterval = 6
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = lastFaceUpDate  {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval  {
            max(0, bonusTimeLimit - faceUpTime)
        }
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit :  0
        }
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
