//
//  ViewController.swift
//  AnimalSounds
//
//  Created by Guilherme Wahlbrink on 2019-04-16.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var animalSoundLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func catButtonTapped(_ sender: Any) {
        let sound = SimpleSound(named: "meow")
        sound.play()
        animalSoundLabel.text = "Meow!"
    }
    
    @IBAction func dogButtonTapped(_ sender: Any) {
        let sound = SimpleSound(named: "woof")
        sound.play()
        animalSoundLabel.text = "Woof!"
    }
    @IBAction func cowButtonTapped(_ sender: Any) {
        let sound = SimpleSound(named: "moo")
        sound.play()
        animalSoundLabel.text = "Moo!"
    }
}

