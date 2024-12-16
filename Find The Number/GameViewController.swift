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
    
    lazy var game = Game(countItems: buttons.count)
    
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
        
        if game.status == .win {
            statusLabel.text = "Вы выиграли!"
            statusLabel.textColor = .green
            statusLabel.font = UIFont.systemFont(ofSize: 32)
        }
    }
}
