//
//  HangmanGame.swift
//  Hangman
//
//  Created by Julia Friberg on 2017-06-21.
//  Copyright © 2017 Julia Friberg. All rights reserved.
//

class HangmanGame {
    
    let correctWord: String
    var guesses: String
    var guessedWord: String
    var difficulty: HangmanDifficulty
    
    
    init(with word: String = WordGenerator.generate(), difficulty: HangmanDifficulty = .easy) {
        correctWord = word.lowercased()
        guesses = ""
        guessedWord = String(repeating: "_", count: correctWord.numberOfCharacters())
        self.difficulty = difficulty
    }
    
    func guess(_ character: Character) -> Bool {
        guesses.append(character)
        
        let index = correctWord.index(of: character)
        guessedWord = guessedWord.replacing(at: index, with: character)
        
        return index.count > 0
    }
    
    func hasWon() -> Bool {
        return guessedWord == correctWord && guessesLeft() > -1
    }
    
    func guessesLeft() -> Int {
        let wrongGuesses = correctWord.charactersNotInString(from: guesses)
        return difficulty.maxWrongGuesses - wrongGuesses.count
    }
    
    func partsToDraw() -> [HangmanDrawingPart] {
        let numberOfIncorrectGuesses = difficulty.maxWrongGuesses - guessesLeft()
        var parts: [HangmanDrawingPart] = []
        
        switch difficulty {
        case .easy:
            parts += [HangmanDrawingPart(rawValue: numberOfIncorrectGuesses)!]
        case .hard:
            parts += [HangmanDrawingPart(rawValue: numberOfIncorrectGuesses*2)!]
            parts += [HangmanDrawingPart(rawValue: numberOfIncorrectGuesses*2-1)!]
        }
        return parts
    }
    
    func points() -> Int {
        return hasWon() ? difficulty.winningPoints + guessesLeft() * difficulty.winningPoints / difficulty.maxWrongGuesses : 0
    }
}

enum HangmanDifficulty {
    case easy
    case hard
    
    var maxWrongGuesses: Int {
        switch self {
        case .easy:
            return 10
        case .hard:
            return 5
        }
    }
    
    var winningPoints: Int {
        switch self {
        case .easy:
            return 100
        case .hard:
            return 200
        }
    }
}

enum HangmanDrawingPart: Int {
    case gallowBase = 1
    case gallowHeight
    case gallowAcross
    case gallowTip
    case head
    case body
    case leftLeg
    case rightLeg
    case leftArm
    case rightArm
}
