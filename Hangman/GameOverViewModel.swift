enum GameOverModel {
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
