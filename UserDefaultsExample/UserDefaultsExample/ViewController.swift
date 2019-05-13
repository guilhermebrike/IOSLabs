//
//  ViewController.swift
//  UserDefaultsExample
//
//  Created by Guilherme Wahlbrink on 2019-05-13.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var bluetoothSwith: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        if defaults.object(forKey: "switchState") != nil {
            bluetoothSwith.isOn = defaults.bool(forKey: "switchState")
        }
        
    }


    @IBAction func saveSwitchState(_ sender: UISwitch) {
        // save the state of the switch
        // -> User Defaults
        
        // 1. get the userDefault object
        let defaults = UserDefaults.standard
        
        // 2. save the state
        
        if sender.isOn {
          defaults.set(true, forKey: "switchState")
        } else {
          defaults.set(false, forKey: "switchState")
        }
    }
}

