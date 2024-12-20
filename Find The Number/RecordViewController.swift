//
//  RecordViewController.swift
//  Find The Number
//
//  Created by Serhii Prysiazhnyi on 20.12.2024.
//

import UIKit

class RecordViewController: UIViewController {

    @IBOutlet weak var recordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let record = UserDefaults.standard.integer(forKey: KeysUserDefaults.recordGame)
        if record != 0 {
            recordLabel.text = "Ваш рекорд: \(record) сек"
        } else {
            recordLabel.text = "Рекорд не установлен"
        }
    }
    
}
