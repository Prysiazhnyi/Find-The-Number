//
//  SettingsTableViewController.swift
//  Find The Number
//
//  Created by Serhii Prysiazhnyi on 19.12.2024.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "selectTimeVC":
            if let vc = segue.destination as? SelectTimeViewController {
                vc.data = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120]
            }
            default :
            break
        }
    }
    

}
