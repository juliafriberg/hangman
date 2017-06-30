
import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var hangmanView: HangmanDrawingView!
    @IBOutlet weak var guessedWordView: GuessedWordView!
    
    @IBOutlet weak var letterButtonsView: LetterButtonsView!
    var hangman: HangmanGame?
    
    
    // MARK - Set up
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateGuessedWordLabel()
        letterButtonsView.createButtons(letters: "abcdefghijklmnopqrstuvwxyz", actionTarget: self)
    }
    
    func restart(with difficulty: HangmanDifficulty) {
        hangmanView.clear()
        letterButtonsView.resetButtons()
        hangman = HangmanGame(difficulty: difficulty)
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
            showGameOverDialog()
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
        
        var gameOverViewModel = unwrappedHangman.hasWon() ? GameOverModel.win : GameOverModel.lose
        
        if(gameOverViewModel == .win && Highscore.isHighscore(unwrappedHangman.points())) {
            Highscore.set(highscore: unwrappedHangman.points())
            gameOverViewModel = .highscoreWin
        }
        
        let alertController = UIAlertController(title: gameOverViewModel.title, message: gameOverViewModel.description(word: unwrappedHangman.correctWord, points: unwrappedHangman.points()), preferredStyle: .alert)
        
        let easyRestartAction = UIAlertAction(title: "Easy", style: .default) { action in
            self.restart(with: HangmanDifficulty.easy)
        }
        
        let hardRestartAction = UIAlertAction(title: "Hard", style: .default) { action in
            self.restart(with: HangmanDifficulty.hard)
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
}



