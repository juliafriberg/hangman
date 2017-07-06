
import UIKit

class MultiplayerViewModel: GameViewModel {
    var delegate: GameDelegate
    var hangman: HangmanGame
    var multiplayerGame: MultiplayerGame
    
    init(with game: MultiplayerGame, delegate: GameDelegate) {
        multiplayerGame = game
        hangman = HangmanGame()
        self.delegate = delegate
    }
    
    func startGame() {
        delegate.show(getChooseNewWordDialog(newGame: true))
    }
    
    func getGameInfoToDisplay() -> String {
        return getCurrentTurnInformation() + getPlayersCurrentInformation()
    }
    
    private func getPlayersCurrentInformation() -> String {
        return  multiplayerGame.players.reduce("", { result, player in
            result + "\(player.name): \(player.score)\n"
        })
    }
    
    private func getCurrentTurnInformation() -> String {
        return "\(multiplayerGame.currentTurn)/\(multiplayerGame.totalTurns)\n"
    }
    
    func showGameOverDialog() {
        delegate.show(multiplayerGame.gameIsOver() ? getMultiplayerGameIsOverDialog() : getChooseNewWordDialog(newGame: false))
    }
    
    private func getMultiplayerGameIsOverDialog() -> UIAlertController {
        let alertController = UIAlertController(title: "End of game", message: "The word was \(hangman.correctWord.uppercased()).\n\n\(getPlayersCurrentInformation())", preferredStyle: .alert)
        
        let restartAction = UIAlertAction(title: "Play again", style: .default) { action in
            self.restart()
        }
        alertController.addAction(restartAction)
        return alertController
    }
    
    private func restart() {
        multiplayerGame = MultiplayerGame(difficulty: multiplayerGame.difficulty)
        delegate.resetUI()
        delegate.show(getChooseNewWordDialog(newGame: true))
    }
    
    private func getChooseNewWordDialog(newGame: Bool) -> UIAlertController {
        var message = ""
        if !newGame {
            message = "The word was \(hangman.correctWord.uppercased()). \(multiplayerGame.getPlayerToChooseWord().name) got \(hangman.points()) points. \n\n"
        }
        message += "\(multiplayerGame.getPlayerToChooseWord().name) choose a new word for \(multiplayerGame.getPlayerToGuessWord().name) to guess."
        
        let alertController = UIAlertController(title: "Choose a new word", message: message, preferredStyle: .alert)
        
        let restartAction = (UIAlertAction(title: "Play", style: .default, handler: {
            alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            if !newGame {
                self.startNextTurn(with: textField.text!)
            } else {
                self.hangman = HangmanGame(with: textField.text!, difficulty: self.multiplayerGame.difficulty)
                self.delegate.updateUI()
            }
        }))
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "New word"
        })
        alertController.addAction(restartAction)
        return alertController
    }
    
    private func startNextTurn(with word: String) {
        multiplayerGame.registerTurn(score: hangman.points())
        hangman = HangmanGame(with: word, difficulty: multiplayerGame.difficulty)
        delegate.resetUI()
    }
}
