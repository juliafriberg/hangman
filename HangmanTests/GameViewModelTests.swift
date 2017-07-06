//
//  GameViewModelTests.swift
//  Hangman
//
//  Created by Julia Friberg on 2017-07-06.
//  Copyright © 2017 Julia Friberg. All rights reserved.
//

import XCTest
@testable import Hangman

class GameViewModelTests: XCTestCase {
    
    var gameViewModel: GameViewModel!
    var delegate: GameDelegateMock!
    
    override func setUp() {
        super.setUp()
        delegate = GameDelegateMock()
        gameViewModel = HangmanViewModel(with: HangmanGame(with: "TestedWord", difficulty: .easy), delegate: delegate)
    }
    
    func testGuess_UpdatedUI() {
        gameViewModel.guess("t")
        
        XCTAssertTrue(delegate.updatedUI)
    }
    
    func testGuess_CorrectGuess_UpdatedGuessedWord() {
        gameViewModel.guess("t")
        let guessedWord = gameViewModel.getGuessedWord()
        
        XCTAssertEqual("t__t______", guessedWord)
    }
    
    func testGuessedWord_Start_Empty() {
        XCTAssertEqual("__________", gameViewModel.getGuessedWord())
    }
    
    
    
    
    
    
}

class GameDelegateMock: GameDelegate {
    var updatedUI = false
    var UIhasBeenReset = false
    var showed = false
    
    func updateUI() {
        updatedUI = true
    }
    
    func resetUI() {
        UIhasBeenReset = true
    }
    
    func show(_ alertController: UIAlertController) {
        showed = true
    }
}
