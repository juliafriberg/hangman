//
//  StartViewController.swift
//  Hangman
//
//  Created by Julia Friberg on 2017-06-27.
//  Copyright © 2017 Julia Friberg. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    
    @IBOutlet weak var highScoreLabel: UILabel!

    @IBOutlet weak var playerSegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        highScoreLabel.text = "\(Highscore.get())"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else { return }
        
        var difficulty: HangmanDifficulty
        switch segueIdentifier {
        case "easy":
            difficulty = .easy
        case "hard":
            difficulty = .hard
        default:
            difficulty = .easy
        }
        
        let hangmanGame = HangmanGame(difficulty: difficulty)
        
        if let destinationViewController = segue.destination as? GameViewController {
            destinationViewController.hangman = hangmanGame
            
            if playerSegmentControl.selectedSegmentIndex == 1 {
                destinationViewController.multiplayerGame = MultiplayerGame(difficulty: difficulty)
            }
        }
    }
    
    
    
    

    

}
