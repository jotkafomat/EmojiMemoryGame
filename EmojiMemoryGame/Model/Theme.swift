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
                             limitPairs: Int.random(in: 2...5),
                             color: .pink)
    static let winter = Theme(name: "Winter",
                              contents: ["🥶", "❄️", "☃️", "⛷", "🏂"],
                              limitPairs: Int.random(in: 2...5),
                              color: .blue)
    static let party = Theme(name: "Party",
                             contents: ["🎉","🥳","🍾","🎁","🎊","🪅","🎂"],
                             limitPairs: Int.random(in: 2...7),
                             color: .green)
    static let glasses = Theme(name: "Glasses",
                            contents: ["😎","🤓","🧐","🕶","🔎","👓","🥸","🥽"],
                            limitPairs: Int.random(in: 2...8),
                            color: .purple)
    static let moon = Theme(name: "Moon",
                            contents: ["🌕","🌖","🌗","🌘","🌑","🌒","🌓","🌔","🌙","🌛","🌜","🌝","🌚"],
                            limitPairs: Int.random(in: 2...13),
                            color: .purple)
    static let city = Theme(name: "Moon",
                            contents: ["🌁","🌆","🌃","🏢","🌇","🏙","🌉"],
                            limitPairs: Int.random(in: 2...7),
                            color: .purple)
    
    
    static let all = [Theme.angry, .winter]
    
    static var random: Theme {
        all.randomElement()!
    }
}
