//
//  Theme.swift
//  Memory
//
//  Created by Krzysztof Jankowski on 16/01/2021.
//

import SwiftUI

struct Theme {
    
    let name: String
    let contents: [String]
    let limitPairs: Int?
    let color: Color
    
    var numberOfPair: Int {
        min(contents.count, limitPairs ?? contents.count)
    }
    
    static let angry = Theme(name: "Angry Emoji",
                             contents: ["😱", "🤬", "💩", "😡", "🤢"],
                             limitPairs: Int.random(in: 1...5),
                             color: .pink)
    static let winter = Theme(name: "Winter",
                              contents: ["🥶", "❄️", "☃️", "⛷", "🏂"],
                              limitPairs: nil,
                              color: .blue)
    
    static let all = [Theme.angry, .winter]
    
    static var random: Theme {
        all.randomElement()!
    }
}
