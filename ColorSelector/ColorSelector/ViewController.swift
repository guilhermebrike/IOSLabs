//
//  ViewController.swift
//  ColorSelector
//
//  Created by Guilherme Wahlbrink on 2019-04-15.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var colorVIew: UIView!
    @IBOutlet var redSwitch: UISwitch!
    @IBOutlet var greenSwitch: UISwitch!
    @IBOutlet var blueSwitch: UISwitch!
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateColor()
    }
    
    @IBAction func redSlider(_ sender: Any) {
    }
    
    @IBAction func greenSlider(_ sender: Any) {
    }
    
    @IBAction func blueSlider(_ sender: Any) {
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        print("reset")
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        redSlider.value = 1
        greenSlider.value = 1
        blueSlider.value = 1
        
        redSwitch.isOn = false
        greenSwitch.isOn = false
        blueSwitch.isOn = false
    }
    
    fileprivate func updateColor() {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        
        if redSwitch.isOn {
            red = 1
        }
        if greenSwitch.isOn {
            green = 1
        }
        if blueSwitch.isOn {
            blue = 1
        }
        
        let bgColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        colorVIew.backgroundColor = bgColor
    }
    

}
