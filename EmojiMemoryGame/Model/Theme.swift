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
    let randomNumber: Bool
    let color: Color
    
    init(name: String,
         contents: [String],
         randomNumber: Bool = false,
         color: Color) {
        self.name = name
        self.contents = contents
        self.randomNumber = randomNumber
        self.color = color
    }
    
    var numberOfPairs: Int {
        contents.count
    }
    
    static let angry = Theme(name: "Angry Emoji",
                             contents: ["😱", "🤬", "💩", "😡", "🤢"],
                             color: .pink)
    static let winter = Theme(name: "Winter",
                              contents: ["🥶", "❄️", "☃️", "⛷", "🏂"],
                              color: .blue)
    static let party = Theme(name: "Party",
                             contents: ["🎉","🥳","🍾","🎁","🎊","🪅","🎂"],
                             color: .green)
    static let glasses = Theme(name: "Glasses",
                            contents: ["😎","🤓","🧐","🕶","🔎","👓","🥸","🥽"],
                            color: .purple)
    static let moon = Theme(name: "Moon",
                            contents: ["🌕","🌖","🌗","🌘","🌑","🌒","🌓","🌔","🌙","🌛","🌜","🌝","🌚"],
                            randomNumber: true,
                            color: .gray)
    static let city = Theme(name: "City",
                            contents: ["🌁","🌆","🌃","🏢","🌇","🏙","🌉"],
                            color: .red)
    
    
    static let all = [Theme.angry, .winter, .party, .city, .glasses, .moon]
    
    static var random: Theme {
        all.randomElement()!
    }
}
