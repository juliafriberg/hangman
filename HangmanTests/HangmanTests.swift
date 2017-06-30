//
//  HangmanTests.swift
//  Hangman
//
//  Created by Julia Friberg on 2017-06-21.
//  Copyright © 2017 Julia Friberg. All rights reserved.
//

import XCTest
@testable import Hangman

class HangmanTests: XCTestCase {
    
    let hangman = HangmanGame(with: "TestedWord")
    
    func testGuesses_AtStart_IsEmpty() {
        XCTAssertTrue(hangman.guesses.numberOfCharacters() == 0)
    }
    
    func testGuessOnce() {
        _ = hangman.guess("p")
        XCTAssertEqual(hangman.guesses, "p")
    }
    
    func testGuessTwice() {
        _ = hangman.guess("p")
        _ = hangman.guess("a")
        XCTAssertEqual(hangman.guesses, "pa")
    }
    
    func testGuess_Correct_IsCorrect() {
        let result = hangman.guess("e")
        XCTAssertTrue(result)
    }
    
    func testGuess_Incorrect_IsIncorrect() {
        let result = hangman.guess("j")
        XCTAssertFalse(result)
    }
    
    func testGuessedWord_CorrectGuess_Updated() {
        _ = hangman.guess("e")
        XCTAssertEqual(hangman.guessedWord, "_e__e_____")
    }
    
    func testGuessedWord_CorrectGuessTwice_Updated() {
        _ = hangman.guess("e")
        _ = hangman.guess("s")
        XCTAssertEqual(hangman.guessedWord, "_es_e_____")
    }
    
    func testGuessedWord_IncorrectGuess_NotUpdated() {
        _ = hangman.guess("j")
        XCTAssertEqual(hangman.guessedWord, "__________")
    }
    
    func testGuessesLeft_FromStart_IsMaxWrongGuesses() {
        XCTAssertEqual(hangman.difficulty.maxWrongGuesses, hangman.guessesLeft())
    }
    
    func testGuessesLeft_AfterGuess_DecreasedByOne() {
        _ = hangman.guess("j")
        XCTAssertEqual(hangman.difficulty.maxWrongGuesses - 1, hangman.guessesLeft())
    }
    
    
    func testUserHasWon_GuessAllCorrectLetters() {
        _ = hangman.guess("t")
        _ = hangman.guess("e")
        _ = hangman.guess("s")
        _ = hangman.guess("d")
        _ = hangman.guess("w")
        _ = hangman.guess("o")
        _ = hangman.guess("r")
        
        XCTAssertTrue(hangman.hasWon())
    }
    
    func testDifficulty_Easy() {
        let hangmanEasy = HangmanGame(difficulty: HangmanDifficulty.easy)
        
        XCTAssertEqual(hangmanEasy.difficulty, HangmanDifficulty.easy)
    }
    
    func testDifficulty_Hard() {
        let hangmanHard = HangmanGame(difficulty: HangmanDifficulty.hard)
        
        XCTAssertEqual(hangmanHard.difficulty, HangmanDifficulty.hard)
    }
    
    func testPartsToDraw_DifficultyEasy_OnePart() {
        let hangmanEasy = HangmanGame(with: "TestedWord", difficulty: HangmanDifficulty.easy)
        _ = hangmanEasy.guess("p")
        let parts = hangmanEasy.partsToDraw()
        
        XCTAssertEqual(parts.count, 1)
    }
    
    func testPartsToDraw_DifficultyHard_TwoParts() {
        let hangmanHard = HangmanGame(with: "TestedWord", difficulty: HangmanDifficulty.hard)
        _ = hangmanHard.guess("p")
        let parts = hangmanHard.partsToDraw()
        
        XCTAssertEqual(parts.count, 2)
    }
    
    func testPointsWhenHasWon_NoIncorrectGuessesEasy_MaxPoints() {
        _ = hangman.guess("t")
        _ = hangman.guess("e")
        _ = hangman.guess("s")
        _ = hangman.guess("d")
        _ = hangman.guess("w")
        _ = hangman.guess("o")
        _ = hangman.guess("r")
        
        
        XCTAssertEqual(hangman.points(), HangmanDifficulty.easy.winningPoints*2)
    }
    
    func testPointsWhenHasWon_NoIncorrectGuessesHard_MaxPoints() {
        let hangmanGame = HangmanGame(with: "TestedWord", difficulty: .hard)
        
        _ = hangmanGame.guess("t")
        _ = hangmanGame.guess("e")
        _ = hangmanGame.guess("s")
        _ = hangmanGame.guess("d")
        _ = hangmanGame.guess("w")
        _ = hangmanGame.guess("o")
        _ = hangmanGame.guess("r")
        
        
        XCTAssertEqual(hangmanGame.points(), HangmanDifficulty.hard.winningPoints*2)
    }
    
    func testPointsWhenHasNotWon_0() {
        XCTAssertEqual(hangman.points(), 0)
    }
    
    func testPointsWhenHasWon_SeveralIncorrectGuessesEasy() {
        _ = hangman.guess("p")
        _ = hangman.guess("k")
        _ = hangman.guess("l")
        _ = hangman.guess("t")
        _ = hangman.guess("e")
        _ = hangman.guess("s")
        _ = hangman.guess("d")
        _ = hangman.guess("w")
        _ = hangman.guess("o")
        _ = hangman.guess("r")
        
        
        XCTAssertEqual(hangman.points(), HangmanDifficulty.easy.winningPoints + 7 * HangmanDifficulty.easy.winningPoints / 10)
    }
    
    func testPointsWhenHasWon_SeveralIncorrectGuessesHard() {
        let hangmanGame = HangmanGame(with: "TestedWord", difficulty: .hard)
        
        _ = hangmanGame.guess("p")
        _ = hangmanGame.guess("k")
        _ = hangmanGame.guess("l")
        _ = hangmanGame.guess("t")
        _ = hangmanGame.guess("e")
        _ = hangmanGame.guess("s")
        _ = hangmanGame.guess("d")
        _ = hangmanGame.guess("w")
        _ = hangmanGame.guess("o")
        _ = hangmanGame.guess("r")
        
        
        XCTAssertEqual(hangmanGame.points(), HangmanDifficulty.hard.winningPoints + 2 * HangmanDifficulty.hard.winningPoints / 5)
    }
}
