import UIKit

protocol GameViewModel {

    var delegate: GameDelegate { get set }
    var hangman: HangmanGame { get set }
    func startGame()
    func guess(_ character: Character)
    func getGuessedWord() -> String
    func getGameInfoToDisplay() -> String
    func gameIsOver() -> Bool
    func showGameOverDialog()
    func partsToDraw() -> [HangmanDrawingPart]
    
}

extension GameViewModel {
    func guess(_ character: Character)  {
        hangman.guess(character)
        delegate.updateUI()
    }
    
    func getGuessedWord() -> String {
        return hangman.guessedWord
    }
    
    func partsToDraw() -> [HangmanDrawingPart] {
        return hangman.partsToDraw()
    }
    
    func gameIsOver() -> Bool {
        return hangman.hasWon() || hangman.numberOfWrongGuesses() >= hangman.difficulty.maxWrongGuesses
    }
}

protocol GameDelegate {
    func resetUI()
    func show(_ alertController: UIAlertController)
    func updateUI()
}

