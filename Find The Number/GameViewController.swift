//
//  GameViewController.swift
//  Find The Number
//
//  Created by Serhii Prysiazhnyi on 16.12.2024.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var nextDidget: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    lazy var game = Game(countItems: buttons.count, time : 30) { [weak self] (status, time) in
        guard let self = self else {return}
        self.timeLabel.text = "\(time)"
        self.updateInfoGame(with : status)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
    
        guard let buttinIndex = buttons.firstIndex(of: sender) else {return}
        game.check(index : buttinIndex)
        updateUI()
    }
    
    private func setupScreen() {
        
        for index in game.items.indices {
            buttons[index].setTitle(game.items[index].title, for: .normal)
            buttons[index].isHidden = false
        }
        
        nextDidget.text = game.nextItem?.title
    }
    
    private func updateUI() {
        
        for index in game.items.indices {
            buttons[index].isHidden = game.items[index].isFound
        }
        nextDidget.text = game.nextItem?.title
        
        updateInfoGame(with : game.status)
    }
    
    private func updateInfoGame(with status : StatusGame) {
        switch status {
        case .start:
            statusLabel.text = "Игра началась!"
            statusLabel.textColor = .black
            statusLabel.font = UIFont.systemFont(ofSize: 32)
        case .win:
            statusLabel.text = "Вы выиграли!"
            statusLabel.textColor = .green
            statusLabel.font = UIFont.systemFont(ofSize: 32)
        case .lose:
            statusLabel.text = "Вы проиграли!"
            statusLabel.textColor = .red
            statusLabel.font = UIFont.systemFont(ofSize: 32)
        }
    }
}
