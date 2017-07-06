
import UIKit

class GameViewController: UIViewController, GameDelegate {
    
    @IBOutlet weak var hangmanView: HangmanDrawingView!
    @IBOutlet weak var guessedWordView: GuessedWordView!
    @IBOutlet weak var letterButtonsView: LetterButtonsView!
    @IBOutlet weak var gameInformationLabel: UILabel!
    
    var gameViewModel: GameViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        letterButtonsView.createButtons(letters: "abcdefghijklmnopqrstuvwxyz", actionTarget: self)
        
        guard let unwrappedGameViewModel = gameViewModel else {
            print("no game started")
            return
        }
        
        unwrappedGameViewModel.startGame()
        
    }
    
    func guessLetter(_ letter: Character) {
        guard let unwrappedGameViewModel = gameViewModel else {
            print("no game started")
            return
        }

        unwrappedGameViewModel.guess(letter)

        if unwrappedGameViewModel.gameIsOver() {
            unwrappedGameViewModel.showGameOverDialog()
       }
    }
    
    
    func resetUI() {
        hangmanView.clear()
        letterButtonsView.resetButtons()
        updateUI()
    }
    
    func updateUI() {
        updateGuessedWordLabel()
        updateGameInfoLabel()
        drawHangman()
    }
    
    func updateGuessedWordLabel() {
        guard let unwrappedGameViewModel = gameViewModel else {
            print("no game started")
            return
        }
        
        guessedWordView.setText(word: unwrappedGameViewModel.getGuessedWord().uppercased())
    }
    
    func updateGameInfoLabel() {
        guard let unwrappedGameViewModel = gameViewModel else {
            print("no game started")
            return
        }
        
        gameInformationLabel.text = unwrappedGameViewModel.getGameInfoToDisplay()
    }

    func drawHangman() {
        guard let unwrappedGameViewModel = gameViewModel else {
            print("no game started")
            return
        }
        
        for part in unwrappedGameViewModel.partsToDraw() {
            hangmanView.add(part: part)
        }
    }
    
    func show(_ alertController: UIAlertController) {
        present(alertController, animated: true)
    }
}
