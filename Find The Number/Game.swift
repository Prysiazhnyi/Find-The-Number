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
    case lose
}

class Game {
    
    struct Item {
        var title : String
        var isFound: Bool = false
        var isError = false
    }
    
    private let data = Array(1...99)
    
     var items: [Item] = []
    
    var nextItem : Item?
    
    var startTimeGame : Int
    
    var isNewRecord = false
    
    var status : StatusGame = .start {
        didSet {
            if status != .start {
                if status == .win {
                let newRecord = startTimeGame - timerForGame
                let record = UserDefaults.standard.integer(forKey: KeysUserDefaults.recordGame)
                
                if record == 0 || newRecord < record {
                    UserDefaults.standard.setValue(newRecord, forKey: KeysUserDefaults.recordGame)
                    isNewRecord = true
                    }
                }
                stopGame()
            }
        }
    }
    
    private var timerForGame : Int {
        didSet {
            if timerForGame == 0 {
                status = .lose
            }
            updateTimer(status, timerForGame)
        }
    }
    
    private var countItem : Int
    
    private var timer : Timer?
    private var updateTimer : ((StatusGame, Int) -> Void)
    
    init(countItems : Int, updateTimer : @escaping (_ status : StatusGame, _ seconds : Int) -> Void) {
        self.countItem = countItems
        self.startTimeGame = Settings.shared.currentSettings.timeForGame
        self.timerForGame = self.startTimeGame
        self.updateTimer = updateTimer
        setupGame()
    }
    
    private func setupGame() {
        isNewRecord = false
        var digits = data.shuffled()
        items.removeAll()
        while items.count < countItem {
            let item = Item(title:  String(digits.removeFirst()))
            items.append(item)
        }
        
        nextItem = items.shuffled().first
        updateTimer(status, timerForGame)
        
        if Settings.shared.currentSettings.timerState {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (_) in
                self?.timerForGame -= 1
            })
        }
    }
    
    func newGame() {
        status = .start
        self.timerForGame = self.startTimeGame
        setupGame()
    }
    
    func check(index : Int) {
        guard status == .start else {return}
        if items[index].title == nextItem?.title {
            items[index].isFound = true
            nextItem = items.shuffled().first(where: {(item) -> Bool in
                item.isFound == false
            })
        } else {
            items[index].isError = true
        }
        if nextItem == nil {
            status = .win
        }
    }
    
    func stopGame() {
        timer?.invalidate()
    }
    
}

extension Int {
    func secondsToString() -> String {
        let minuts = self / 60
        let second = self % 60
        
        return String(format: "%d:%02d", minuts, second)
    }
}
