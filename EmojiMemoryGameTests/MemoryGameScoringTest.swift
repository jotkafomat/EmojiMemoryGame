//
//  MemoryGameScoringTest.swift
//  MemoryTests
//
//  Created by Krzysztof Jankowski on 16/01/2021.
//

import XCTest
@testable import Memory

class MemoryGameScoringTest: XCTestCase {
    var memoryGame: MemoryGame<String>!
    
    var a1: MemoryGame<String>.Card {
        memoryGame.cards.first(where: { $0.content == "a" })!
    }
    
    var a2: MemoryGame<String>.Card {
        memoryGame.cards.last(where: { $0.content == "a" })!
    }
    
    var b1: MemoryGame<String>.Card {
        memoryGame.cards.first(where: { $0.content == "b" })!
    }
    
    var b2: MemoryGame<String>.Card {
        memoryGame.cards.last(where: { $0.content == "b" })!
    }
    
    var c1: MemoryGame<String>.Card {
        memoryGame.cards.first(where: { $0.content == "c" })!
    }
    
    var c2: MemoryGame<String>.Card {
        memoryGame.cards.last(where: { $0.content == "c" })!
    }

    override func setUpWithError() throws {
        memoryGame = MemoryGame(numberOfPairsOfCards: 3, cardContentFactory: { index in ["a", "b", "c"][index] })
    }

    override func tearDownWithError() throws {
        
        memoryGame = nil
    }

    func testScoreForMatch()  {
        memoryGame.choose(card: a1)
        memoryGame.choose(card: a2)
        XCTAssertEqual(memoryGame.score, 2)
    }
    
    func testNoMatchNoScore() {
        memoryGame.choose(card: a1)
        memoryGame.choose(card: b2)
        XCTAssertEqual(memoryGame.score, 0)
    }
    
    func testScoreForThreeMatches() {
        memoryGame.choose(card: a1)
        memoryGame.choose(card: a2)
        memoryGame.choose(card: b1)
        memoryGame.choose(card: b2)
        memoryGame.choose(card: c1)
        memoryGame.choose(card: c2)
        XCTAssertEqual(memoryGame.score, 6)
    }
}
