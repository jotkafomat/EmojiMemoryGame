//
//  GridView.swift
//  Memory
//
//  Created by Krzysztof Jankowski on 30/12/2020.
//

import SwiftUI

struct GridView<Item, ItemView>: View where Item: Identifiable , ItemView: View {
    
    var items: [Item]
    var viewForItem: (Item) -> ItemView
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(items) { item in
                self.viewForItem(item)
            }
        }
    }
}

