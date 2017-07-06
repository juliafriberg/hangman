import UIKit

class HangmanViewModel: GameViewModel {
    var hangman: HangmanGame
    var delegate: GameDelegate
    
    init(with hangmanGame: HangmanGame, delegate: GameDelegate) {
        hangman = hangmanGame
        self.delegate = delegate
    }
    
    func startGame() {
        delegate.updateUI()
    }
    
    func getGameInfoToDisplay() -> String {
        return "Highscore: \(Highscore.get())"
    }
    
    func showGameOverDialog() {
        
        let gameOverState = getGameOverState()
        
        let alertController = UIAlertController(title: gameOverState.title, message: gameOverState.description(word: hangman.correctWord, points: hangman.points()), preferredStyle: .alert)
        
        let easyRestartAction = UIAlertAction(title: "Easy", style: .default) { action in
            self.restart(with: HangmanDifficulty.easy)
        }
        
        let hardRestartAction = UIAlertAction(title: "Hard", style: .default) { action in
            self.restart(with: HangmanDifficulty.hard)
        }
        
        alertController.addAction(easyRestartAction)
        alertController.addAction(hardRestartAction)
        
        delegate.show(alertController)
    }
    
    private func restart(with difficulty: HangmanDifficulty) {
        hangman = HangmanGame(difficulty: difficulty)
        delegate.resetUI()
    }
    
    private func getGameOverState() -> GameOverState {
        var gameOverState = hangman.hasWon() ? GameOverState.win : GameOverState.lose
        
        if(gameOverState == .win && Highscore.isHighscore(hangman.points())) {
            gameOverState = .highscoreWin
            setHighscore(hangman.points())
        }
        return gameOverState
    }
    
    private func setHighscore(_ points: Int) {
        Highscore.set(highscore: points)
    }
}

enum GameOverState {
    case win
    case lose
    case highscoreWin
    
    var title: String {
        switch self {
        case .win:
            return "You won!"
        case .lose:
            return "Game over"
        case .highscoreWin:
            return "New high score!"
        }
    }
    
    func description(word: String, points: Int) -> String {
        switch self {
        case .win:
            return "The word was \(word). You scored \(points). Choose a difficulty to play again."
        case .lose:
            return "The word was \(word). Choose a difficulty to try again."
        case .highscoreWin:
            return "Congratulations! Your new high score is \(points). The word was \(word). Choose a difficulty to play again."
        }
    }
}

