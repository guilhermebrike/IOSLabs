//
//  ViewController.swift
//  RockPaperScissor
//
//  Created by Guilherme Wahlbrink on 2019-04-23.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var appSign: UILabel!
    @IBOutlet var gameStatus: UILabel!
    @IBOutlet var rockButton: UIButton!
    @IBOutlet var paperButton: UIButton!
    @IBOutlet var scissorsButton: UIButton!
    @IBOutlet var playAgainButton: UIButton!
    
    private var state: GameState = .Start
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    fileprivate func updateUI() {
        // 1. set game status label with appropriate message
        // 2. set background color(white, blue, yellow, red)
        switch state {
        case .Start:
            gameStatus.text = "Rock, Paper, Scissors?"
            view.backgroundColor = .white
            playAgainButton.isHidden = true
            appSign.text = "🤖"
            rockButton.isEnabled = true
            paperButton.isEnabled = true
            scissorsButton.isEnabled = true
        case .Win:
            gameStatus.text = "You won!"
            view.backgroundColor = .blue
            playAgainButton.isHidden = false
            rockButton.isEnabled = false
            paperButton.isEnabled = false
            scissorsButton.isEnabled = false
        case .Draw:
            gameStatus.text = "Draw!"
            view.backgroundColor = .yellow
            playAgainButton.isHidden = false
            rockButton.isEnabled = false
            paperButton.isEnabled = false
            scissorsButton.isEnabled = false
        case .Lose:
            gameStatus.text = "You Lost!"
            view.backgroundColor = .red
            playAgainButton.isHidden = false
            rockButton.isEnabled = false
            paperButton.isEnabled = false
            scissorsButton.isEnabled = false
        }
    }
    
    
    @IBAction func play(_ sender: UIButton) {
        // tap on either choise
        // 1. get the random computer sign
        let compSign = randomSign()
        
        // 2. which button is tapped?
        if sender.tag == 1 {
            // rock
            let mySign = Sign.Rock
            state = mySign.getGameState(other: compSign)
        } else if sender.tag == 2 {
            // paper
            let mySign = Sign.Paper
            state = mySign.getGameState(other: compSign)
        } else if sender.tag == 3 {
            // scissors
            let mySign = Sign.Scissors
            state = mySign.getGameState(other: compSign)
        }
        
        updateUI()
    }
    
    
    @IBAction func playAgain(_ sender: UIButton) {
        state = .Start
        updateUI()
    }
    
}

