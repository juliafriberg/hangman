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
        guessedWord = String(repeating: "_", count: correctWord.count())
        self.difficulty = difficulty
    }
    
    func guess(_ guessedCharacter: Character) {
        guesses += "\(guessedCharacter)"
        updateGuessedWord(with: guessedCharacter)
    }
    
    func hasWon() -> Bool {
        return guessedWord == correctWord && numberOfWrongGuesses() <= difficulty.maxWrongGuesses
    }
    
    func numberOfWrongGuesses() -> Int {
        return correctWord.charactersOnlyInGivenString(guesses).count
    }
    
    func partsToDraw() -> [HangmanDrawingPart] {
        var parts: [HangmanDrawingPart] = []
        if numberOfWrongGuesses() > 0 && numberOfWrongGuesses() <= difficulty.maxWrongGuesses {
            switch difficulty {
            case .easy:
                parts += [HangmanDrawingPart(rawValue: numberOfWrongGuesses())!]
            case .hard:
                parts += [HangmanDrawingPart(rawValue: numberOfWrongGuesses()*2)!]
                parts += [HangmanDrawingPart(rawValue: numberOfWrongGuesses()*2-1)!]
            }

        }
        return parts
    }
    
    func points() -> Int {
        var points = 0
        if hasWon() {
            points += difficulty.winningPoints
            points -= numberOfWrongGuesses() * difficulty.winningPoints / difficulty.maxWrongGuesses
        }
        
        return points
    }
    
    private func updateGuessedWord(with character: Character) {
        let indices = correctWord.indices(of: character)
        guessedWord = guessedWord.replace(at: indices, with: character)
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
