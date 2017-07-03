
class MultiplayerGame {
    let difficulty: HangmanDifficulty
    var currentTurn = 1
    var totalTurns = 6
    var players = [Player(name: "Player1"), Player(name: "Player2")]
    
    init(difficulty: HangmanDifficulty) {
        self.difficulty = difficulty
    }
    
    func turnIsOver(score: Int) {
        let currentPlayer = getPlayerToGuess()
        currentPlayer.score += score
        currentTurn += 1
        
    }
    
    func getPlayerToGuess() -> Player {
        return currentTurn % 2 == 0 ? players[1] : players[0]
    }
    
    func getPlayerToChooseWord() -> Player {
        return currentTurn % 2 == 0 ? players[0] : players[1]
    }
    
    func gameIsOver() -> Bool {
        return currentTurn > totalTurns
    }
    
    func winningPlayer() -> Player {
        return players[0].score > players[1].score ? players[0] : players[1]
    }
    
    func losingPlayer() -> Player {
        return players[0].score < players[1].score ? players[0] : players[1]
    }
}

class Player {
    var score: Int = 0
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

extension Player: Equatable {
    static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name && lhs.score == rhs.score
    }
}
