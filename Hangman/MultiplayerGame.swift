struct MultiplayerGame {
    let difficulty: HangmanDifficulty
    var currentTurn = 1
    var totalTurns = 6
    var players = [Player(name: "Player1"), Player(name: "Player2")]
    
    
    
    init(difficulty: HangmanDifficulty) {
        self.difficulty = difficulty
    }
    
    mutating func turnIsOver(score: Int) {
        let currentPlayer = getPlayerForCurrentTurn()
        currentPlayer.score = score
        currentTurn += 1
        
    }
    
    func getPlayerForCurrentTurn() -> Player {
        return currentTurn % 2 == 0 ? players[1] : players[0]
    }
    
    func isGameOver() -> Bool {
        return currentTurn > totalTurns
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
