//
//  Array+Identifiable.swift
//  Memory
//
//  Created by Krzysztof Jankowski on 31/12/2020.
//

import Foundation
extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
