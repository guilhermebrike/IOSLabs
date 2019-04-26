//
//  ViewController.swift
//  MemeGenerator
//
//  Created by Guilherme Wahlbrink on 2019-04-24.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var topCaptionSegmentedControl: UISegmentedControl!
    @IBOutlet var bottomCaptionSegmentedControl: UISegmentedControl!
    @IBOutlet var topCaptionLabel: UILabel!
    @IBOutlet var bottomCaptionLabel: UILabel!
    
    let topChoises = [CaptionOption(emoji: "🕶", caption: "You Know what's cool?"),CaptionOption(emoji: "💥", caption: "You Know what makes me mad?"),CaptionOption(emoji: "💕", caption: "You know what I love?")]
    
    let bottomChoises = [CaptionOption(emoji: "🐱", caption: "Cats wearing hats"),CaptionOption(emoji: "🐕", caption: "Dogs carrying logs"),CaptionOption(emoji: "🐒", caption: "Monkeys being funky")]
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topCaptionSegmentedControl.removeAllSegments()
        
        for choise in topChoises {
            topCaptionSegmentedControl.insertSegment(withTitle: choise.emoji, at: topChoises.count, animated: false)
        }
        
        topCaptionSegmentedControl.selectedSegmentIndex = 0
        
        bottomCaptionSegmentedControl.removeAllSegments()
        
        for choise in bottomChoises {
            bottomCaptionSegmentedControl.insertSegment(withTitle: choise.emoji, at: bottomChoises.count, animated: false)
        }
        
        bottomCaptionSegmentedControl.selectedSegmentIndex = 0
    }

    @IBAction func optionSelected(_ sender: UISegmentedControl) {
        if sender.tag == 1 {
            topCaptionLabel.text = topChoises[sender.selectedSegmentIndex].caption
        } else {
            bottomCaptionLabel.text = bottomChoises[sender.selectedSegmentIndex].caption
        }
    }
    
}

