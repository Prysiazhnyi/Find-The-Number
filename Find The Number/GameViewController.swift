//
//  GameViewController.swift
//  Find The Number
//
//  Created by Serhii Prysiazhnyi on 16.12.2024.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        print(sender.currentTitle)
        sender.isHidden = true
    }
    
}
