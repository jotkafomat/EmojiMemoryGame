//
//  MemoryGameTests.swift
//  MemoryTests
//
//  Created by Krzysztof Jankowski on 23/12/2020.
//

import XCTest
@testable import Memory

class MemoryGameTests: XCTestCase {

    func testMemoryGameInit() throws {
        let game = MemoryGame(numberOfPairsOfCards: 1, cardContentFactory: { index in "\(index)" })
        XCTAssertEqual(game.cards.count, 2)
        XCTAssertEqual(game.cards[0].content, "0")
        XCTAssertEqual(game.cards[1].content, "0")
    }
    
    func testMemoryGameInitShuffledCards() throws {
        let game = MemoryGame(numberOfPairsOfCards: 4, cardContentFactory: { index in "\(index)" })
        XCTAssertEqual(game.cards.count, 8)
        XCTAssertNotEqual(game.cards.map { $0.content }, ["0","0","1","1","2","2","3","3"])
        XCTAssertEqual(game.cards.map { $0.content }.sorted(), ["0","0","1","1","2","2","3","3"])
    }
}
