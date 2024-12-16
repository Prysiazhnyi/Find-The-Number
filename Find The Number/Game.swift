//
//  Game.swift
//  Find The Number
//
//  Created by Serhii Prysiazhnyi on 16.12.2024.
//

import Foundation

enum StatusGame {
    case start
    case win
}

class Game {
    
    struct Item {
        var title : String
        var isFound: Bool = false
    }
    
    private let data = Array(1...99)
    
     var items: [Item] = []
    
    var nextItem : Item?
    
    var status : StatusGame = .start
    
    private var countItem : Int
    
    init(countItems : Int) {
        self.countItem = countItems
        setupGame()
    }
    
    private func setupGame() {
        var digits = data.shuffled()
        
        while items.count < countItem {
            let item = Item(title:  String(digits.removeFirst()))
            items.append(item)
        }
        
        nextItem = items.shuffled().first
    }
    
    func check(index : Int) {
        
        if items[index].title == nextItem?.title {
            items[index].isFound = true
            nextItem = items.shuffled().first(where: {(item) -> Bool in
                item.isFound == false
            })
        }
        if nextItem == nil {
            status = .win
        }
    }
    
}
