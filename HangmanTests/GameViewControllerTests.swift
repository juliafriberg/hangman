//
//  GameViewControllerTests.swift
//  Hangman
//
//  Created by Julia Friberg on 2017-06-28.
//  Copyright © 2017 Julia Friberg. All rights reserved.
//

import XCTest
@testable import Hangman

class GameViewControllerTests: XCTestCase {
    var viewController: GameViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        viewController = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        
        XCTAssertNotNil(viewController.view)
        
        viewController.gameViewModel = HangmanViewModel(with: HangmanGame(with: "TestedWord"), delegate: viewController)
        viewController.gameViewModel?.startGame()
    }
    
    func testSetTextForGuessedWordLabel() {
        viewController.guessedWordView.setText(word: "Test")
        let updatedText = viewController.guessedWordView.guessedWordLabel.text
        
        XCTAssertEqual("Test", updatedText)
    }
    
    func testGuess_CorrectGuess_UpdateGuessedWordLabel() {
        viewController.guessLetter("t")
        let textAfterGuess = viewController.guessedWordView.guessedWordLabel.text
        
        XCTAssertEqual("T__T______", textAfterGuess)
    }
    
    func testGuess_IncorrectGuess_NotUpdateGuessedWordLabel() {
        let textBeforeGuess = viewController.guessedWordView.guessedWordLabel.text
        
        viewController.guessLetter("p")
        let textAfterGuess = viewController.guessedWordView.guessedWordLabel.text
        
        XCTAssertEqual(textBeforeGuess, textAfterGuess)
    }
    
    func testGuess_IncorrectGuessEasyDifficulty_AddPartToHangmanDrawing() {
        let numberOfPartLayersBefore = viewController.hangmanView.partLayers.count
        
        viewController.guessLetter("p")
        let numberOfPartLayersAfter = viewController.hangmanView.partLayers.count
        
        XCTAssertEqual(numberOfPartLayersBefore + 1, numberOfPartLayersAfter)
    }
    
    func testGuess_CorrectGuessEasyDifficulty_NotAddPartToHangmanDrawing() {
        let numberOfPartLayersBefore = viewController.hangmanView.partLayers.count
        
        viewController.guessLetter("t")
        let numberOfPartLayersAfter = viewController.hangmanView.partLayers.count
        
        XCTAssertEqual(numberOfPartLayersBefore, numberOfPartLayersAfter)
    }
    
    func testGuess_IncorrectGuessHardDifficulty_AddTwoPartsToHangmanDrawing() {
        viewController.gameViewModel = HangmanViewModel(with: HangmanGame(with: "TestedWord", difficulty: .hard), delegate: viewController)
        let numberOfPartLayersBefore = viewController.hangmanView.partLayers.count
        
        viewController.guessLetter("p")
        let numberOfPartLayersAfter = viewController.hangmanView.partLayers.count
        
        XCTAssertEqual(numberOfPartLayersBefore + 2, numberOfPartLayersAfter)
    }
    
    func testGuess_CorrectGuessHardDifficulty_NotAddPartToHangmanDrawing() {
        viewController.gameViewModel = HangmanViewModel(with: HangmanGame(with: "TestedWord", difficulty: .hard), delegate: viewController)
        let numberOfPartLayersBefore = viewController.hangmanView.partLayers.count
        
        viewController.guessLetter("t")
        let numberOfPartLayersAfter = viewController.hangmanView.partLayers.count
        
        XCTAssertEqual(numberOfPartLayersBefore, numberOfPartLayersAfter)
    }
}
