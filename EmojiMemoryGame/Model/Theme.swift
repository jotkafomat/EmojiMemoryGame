//
//  Theme.swift
//  Memory
//
//  Created by Krzysztof Jankowski on 16/01/2021.
//

import SwiftUI

struct Theme: Codable {
    
    let name: String
    let contents: [String]
    let color: Color
    
    init(name: String,
         contents: [String],
         randomNumber: Bool = false,
         color: Color,
         numberOfPairs: Int? = nil
         ) {
        self.name = name
        self.contents = contents
        self.color = color
        if let numberOfPairs = numberOfPairs {
            self.numberOfPairs = min(numberOfPairs, contents.count)
        } else {
            self.numberOfPairs = contents.count
        }
    }
    
    let numberOfPairs: Int
    
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
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
}

fileprivate extension Color {
    #if os(macOS)
    typealias SystemColor = NSColor
    #else
    typealias SystemColor = UIColor
    #endif
    
    var colorComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        #if os(macOS)
        SystemColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)
        // Note that non RGB color will raise an exception, that I don't now how to catch because it is an Objc exception.
        #else
        guard SystemColor(self).getRed(&r, green: &g, blue: &b, alpha: &a) else {
            // Pay attention that the color should be convertible into RGB format
            // Colors using hue, saturation and brightness won't work
            return nil
        }
        #endif
        
        return (r, g, b, a)
    }
}

extension Color: Codable {
    enum CodingKeys: String, CodingKey {
        case red, green, blue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let r = try container.decode(Double.self, forKey: .red)
        let g = try container.decode(Double.self, forKey: .green)
        let b = try container.decode(Double.self, forKey: .blue)
        
        self.init(red: r, green: g, blue: b)
    }

    public func encode(to encoder: Encoder) throws {
        guard let colorComponents = self.colorComponents else {
            return
        }
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(colorComponents.red, forKey: .red)
        try container.encode(colorComponents.green, forKey: .green)
        try container.encode(colorComponents.blue, forKey: .blue)
    }
}
