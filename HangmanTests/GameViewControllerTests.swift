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
        
        // Test and Load the View at the Same Time!
        XCTAssertNotNil(viewController.view)
        
        
        viewController.hangman = HangmanGame(with: "TestedWord")
    }
    
    override func tearDown() {
        
        super.tearDown()
        
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
        viewController.hangman = HangmanGame(with: "TestedWord", difficulty: .hard)
        let numberOfPartLayersBefore = viewController.hangmanView.partLayers.count
        
        viewController.guessLetter("p")
        let numberOfPartLayersAfter = viewController.hangmanView.partLayers.count
        
        XCTAssertEqual(numberOfPartLayersBefore + 2, numberOfPartLayersAfter)
    }
    
    func testGuess_CorrectGuessHardDifficulty_NotAddPartToHangmanDrawing() {
        viewController.hangman = HangmanGame(with: "TestedWord", difficulty: .hard)
        let numberOfPartLayersBefore = viewController.hangmanView.partLayers.count
        
        viewController.guessLetter("t")
        let numberOfPartLayersAfter = viewController.hangmanView.partLayers.count
        
        XCTAssertEqual(numberOfPartLayersBefore, numberOfPartLayersAfter)
    }
    
    func testRestart_GuessedWordResets() {
        viewController.guessedWordView.setText(word: "Test")
        viewController.restart(with: .easy)
        let correctResetWord = String(repeating: "_", count: viewController.hangman!.correctWord.numberOfCharacters())
        let actualResetWord = viewController.guessedWordView.guessedWordLabel.text
        XCTAssertEqual(correctResetWord, actualResetWord)
    }
    
    func testRestart_HangmanDrawingClears() {
        viewController.hangmanView.add(part: HangmanDrawingPart.body)
        viewController.restart(with: .easy)
        let numberOfPartLayers = viewController.hangmanView.partLayers.count
        XCTAssertEqual(0, numberOfPartLayers)
    }
    
}
