//
//  ViewController.swift
//  ColorSelector
//
//  Created by Derrick Park on 2019-04-15.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var colorView: UIView!
  
  @IBOutlet var redSwitch: UISwitch!
  @IBOutlet var greenSwitch: UISwitch!
  @IBOutlet var blueSwitch: UISwitch!
  
  @IBOutlet var redSlider: UISlider!
  @IBOutlet var greenSlider: UISlider!
  @IBOutlet var blueSlider: UISlider!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    colorView.layer.borderWidth = 5.0
    colorView.layer.cornerRadius = 20
    colorView.layer.borderColor = UIColor.black.cgColor
    
    
    let defaults = UserDefaults.standard
    
    if defaults.object(forKey: "switchState1") != nil {
        redSwitch.isOn = defaults.bool(forKey: "switchState1")
    }
    if defaults.object(forKey: "switchState2") != nil {
        greenSwitch.isOn = defaults.bool(forKey: "switchState2")
    }
    if defaults.object(forKey: "switchState3") != nil {
        blueSwitch.isOn = defaults.bool(forKey: "switchState3")
    }
    
    if defaults.object(forKey: "redSliderValue") != nil {
        redSlider.value = defaults.float(forKey: "redSliderValue")
    }
    if defaults.object(forKey: "greenSliderValue") != nil {
        greenSlider.value = defaults.float(forKey: "greenSliderValue")
    }
    if defaults.object(forKey: "blueSliderValue") != nil {
        blueSlider.value = defaults.float(forKey: "blueSliderValue")
    }
    
    updateControls()
    updateColor()
  }

  fileprivate func updateColor() {
    
    let defaults = UserDefaults.standard
    
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    
    

    if redSwitch.isOn {
      red = CGFloat(redSlider.value)
    }
    if greenSwitch.isOn {
      green = CGFloat(greenSlider.value)
    }
    if blueSwitch.isOn {
      blue = CGFloat(blueSlider.value)
    }
    let bgColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    colorView.backgroundColor = bgColor
    
    defaults.set(redSlider.value, forKey: "redSliderValue")
    defaults.set(greenSlider.value, forKey: "greenSliderValue")
    defaults.set(blueSlider.value, forKey: "blueSliderValue")
    
    
  }
  
  fileprivate func updateControls() {
    redSlider.isEnabled = redSwitch.isOn
    greenSlider.isEnabled = greenSwitch.isOn
    blueSlider.isEnabled = blueSwitch.isOn
  }
  
  @IBAction func switchChanged(_ sender: UISwitch) {
    
    let defaults = UserDefaults.standard
    
    if sender.tag == 1 {
        if sender.isOn {
            defaults.set(true, forKey: "switchState1")
        } else {
            defaults.set(false, forKey: "switchState1")
        }
    }
    if sender.tag == 2 {
        if sender.isOn {
            defaults.set(true, forKey: "switchState2")
        } else {
            defaults.set(false, forKey: "switchState2")
        }
    }
    if sender.tag == 3 {
        if sender.isOn {
            defaults.set(true, forKey: "switchState3")
        } else {
            defaults.set(false, forKey: "switchState3")
        }
    }
    
    updateControls()
    updateColor()
  }
  @IBAction func sliderChanged(_ sender: UISlider) {
    updateColor()
  }
  
  @IBAction func resetButtonTapped(_ sender: UIButton) {
    redSlider.value = 1
    greenSlider.value = 1
    blueSlider.value = 1
    
    redSwitch.isOn = false
    greenSwitch.isOn = false
    blueSwitch.isOn = false
    
    updateControls()
    updateColor()
  }
  
}

