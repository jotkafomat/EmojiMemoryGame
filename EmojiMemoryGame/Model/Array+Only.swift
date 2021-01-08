//
//  Array+Only.swift
//  Memory
//
//  Created by Krzysztof Jankowski on 08/01/2021.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
