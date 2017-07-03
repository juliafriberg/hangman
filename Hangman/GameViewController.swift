
import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var hangmanView: HangmanDrawingView!
    @IBOutlet weak var guessedWordView: GuessedWordView!
    
    @IBOutlet weak var letterButtonsView: LetterButtonsView!
    var hangman: HangmanGame?
    var multiplayerGame: MultiplayerGame?
    
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    @IBOutlet weak var turnLabel: UILabel!
    
    // MARK - Set up
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if multiplayerGame != nil {
            showStartMultiplayerDialog()
            updateMultiplayerLabels()
        } else {
            player1Label.isHidden = true
            player2Label.isHidden = true
            turnLabel.isHidden = true
        }
        updateGuessedWordLabel()
        letterButtonsView.createButtons(letters: "abcdefghijklmnopqrstuvwxyz", actionTarget: self)
    }
    
    func restart(with difficulty: HangmanDifficulty, word: String?, multiplayer: Bool) {
        hangmanView.clear()
        letterButtonsView.resetButtons()
        
        if word != nil {
            hangman = HangmanGame(with: word!, difficulty: difficulty)
        } else {
            hangman = HangmanGame(difficulty: difficulty)
        }
        
        updateGuessedWordLabel()
    }
    
    // MARK - Game
    
    func guessLetter(_ letter: Character) {
        guard let unwrappedHangman = hangman else {
            print("No game initialized")
            return
        }
        
        let guessIsCorrect = unwrappedHangman.guess(letter)
        
        if(guessIsCorrect) {
            updateGuessedWordLabel()
        } else {
            drawHangman()
        }
        
        if unwrappedHangman.hasWon() || unwrappedHangman.guessesLeft() == 0 {
            if multiplayerGame != nil {
                multiplayerTurnOver()
            } else {
               showGameOverDialog()
            }
            
        }
    }
    
    func drawHangman() {
        guard let unwrappedHangman = hangman else { return }
        
        for part in unwrappedHangman.partsToDraw() {
            hangmanView.add(part: part)
        }
    }
    
    func showGameOverDialog() {
        guard let unwrappedHangman = hangman else { return }
        
        var gameOverViewModel = unwrappedHangman.hasWon() ? GameOverViewModel.win : GameOverViewModel.lose
        
        if(gameOverViewModel == .win && Highscore.isHighscore(unwrappedHangman.points())) {
            Highscore.set(highscore: unwrappedHangman.points())
            gameOverViewModel = .highscoreWin
        }
        
        let alertController = UIAlertController(title: gameOverViewModel.title, message: gameOverViewModel.description(word: unwrappedHangman.correctWord, points: unwrappedHangman.points()), preferredStyle: .alert)
        
        let easyRestartAction = UIAlertAction(title: "Easy", style: .default) { action in
            self.restart(with: HangmanDifficulty.easy, word: nil, multiplayer: false)
        }
        
        let hardRestartAction = UIAlertAction(title: "Hard", style: .default) { action in
            self.restart(with: HangmanDifficulty.hard, word: nil,  multiplayer: false)
        }
        
        alertController.addAction(easyRestartAction)
        alertController.addAction(hardRestartAction)
        
        self.present(alertController, animated: true) {
            // ...
        }
    }
    
    func updateGuessedWordLabel() {
        guard let unwrappedHangman = hangman else {
            print("no game started")
            return
        }
        guessedWordView.setText(word: unwrappedHangman.guessedWord.uppercased())
    }
    
    func multiplayerTurnOver() {
        guard let unwrappedMultiplayerGame = multiplayerGame,
            let unwrappedHangmanGame = hangman else { return }
        
        unwrappedMultiplayerGame.turnIsOver(score: unwrappedHangmanGame.points())
        updateMultiplayerLabels()
        
        if unwrappedMultiplayerGame.gameIsOver() {
            showMultiplayerGameIsOverDialog()
        } else {
            showMulitplayerTurnIsOverDialog()
        }
    }
    
    func showMultiplayerGameIsOverDialog() {
        guard let unwrappedMultiplayerGame = multiplayerGame,
            let unwrappedHangman = hangman else { return }
        
        let alertController = UIAlertController(title: "End of game", message: "The word was \(unwrappedHangman.correctWord.uppercased()). \(unwrappedMultiplayerGame.winningPlayer().name) won with \(unwrappedMultiplayerGame.winningPlayer().score) points against \(unwrappedMultiplayerGame.losingPlayer().name) with \(unwrappedMultiplayerGame.losingPlayer().score) points.", preferredStyle: .alert)
        
        let restartAction = UIAlertAction(title: "Play again", style: .default) { action in
            self.multiplayerGame = MultiplayerGame(difficulty: unwrappedMultiplayerGame.difficulty)
            self.updateMultiplayerLabels()
            self.showStartMultiplayerDialog()
            
        }
        
        alertController.addAction(restartAction)
        
        self.present(alertController, animated: true) {
            // ...
        }
    }
    
    func showMulitplayerTurnIsOverDialog() {
        guard let unwrappedMultiplayerGame = multiplayerGame,
            let unwrappedHangman = hangman else { return }
        
        let alertController = UIAlertController(title: "Turn is over", message: "The word was \(unwrappedHangman.correctWord.uppercased()). \(unwrappedMultiplayerGame.getPlayerToChooseWord().name) got \(unwrappedHangman.points()). \(unwrappedMultiplayerGame.getPlayerToChooseWord().name) choose a new word for \(unwrappedMultiplayerGame.getPlayerToGuess().name) to guess.", preferredStyle: .alert)
        
        let restartAction = (UIAlertAction(title: "Play", style: .default, handler: {
            alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            self.restart(with: unwrappedMultiplayerGame.difficulty, word: textField.text, multiplayer: true)
            
        }))
        
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "New word"
        })
        
        alertController.addAction(restartAction)
        
        self.present(alertController, animated: true) {
            // ...
        }
    }
    
    func showStartMultiplayerDialog() {
        guard let unwrappedHangman = hangman, let unwrappedMultiplayerGame = multiplayerGame else { return }
        
        let alertController = UIAlertController(title: "New word", message: "\(unwrappedMultiplayerGame.getPlayerToChooseWord().name) choose a new word for \(unwrappedMultiplayerGame.getPlayerToGuess().name) to guess.", preferredStyle: .alert)
        
        let restartAction = (UIAlertAction(title: "Play", style: .default, handler: {
            alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            self.restart(with: unwrappedHangman.difficulty, word: textField.text, multiplayer: true)
        }))
        
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "New word"
        })
        
        alertController.addAction(restartAction)
        
        self.present(alertController, animated: true) {
            // ...
        }
        
    }
    
    func updateMultiplayerLabels() {
        guard let unwrappedMultiplayerGame = multiplayerGame else { return }
        
        let player1 = unwrappedMultiplayerGame.players[0]
        player1Label.text = "\(player1.name): \(player1.score)"
        
        let player2 = unwrappedMultiplayerGame.players[1]
        player2Label.text = "\(player2.name): \(player2.score)"
        
        turnLabel.text = "\(unwrappedMultiplayerGame.currentTurn)/\(unwrappedMultiplayerGame.totalTurns)"
    }
    
}



