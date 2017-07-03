
import XCTest
@testable import Hangman

class MultiplayerGameTests: XCTestCase {
    
    var multiplayerGame = MultiplayerGame(difficulty: .easy)
    
    func testPlayerOneScore_Start_IsZero() {
        XCTAssertEqual(0, multiplayerGame.players[0].score)
    }
    
    func testPlayerTwoScore_Start_IsZero() {
        XCTAssertEqual(0, multiplayerGame.players[1].score)
    }
    
    func testCurrentTurn_Start_IsOne() {
        XCTAssertEqual(1, multiplayerGame.currentTurn)
    }
    
    func testTotalTurns_IsSix() {
        XCTAssertEqual(6, multiplayerGame.totalTurns)
    }
    
    func testTurnIsOver_CurrentTurnIncreases() {
        let turnBefore = multiplayerGame.currentTurn
        
        multiplayerGame.turnIsOver(score: 0)
        let turnAfter = multiplayerGame.currentTurn
        
        XCTAssertEqual(turnBefore + 1, turnAfter)
    }
    
    func testTurnIsOver_Player1HasGuessed_ScoreIncreases() {
        multiplayerGame.turnIsOver(score: 150)
        
        let scoreAfter = multiplayerGame.players[0].score
        
        XCTAssertEqual(150, scoreAfter)
    }
    
    func testTurnIsOver_Player2HasGuessed_ScoreIncreases() {
        multiplayerGame.turnIsOver(score: 150)
        multiplayerGame.turnIsOver(score: 100)
        
        let scoreAfter = multiplayerGame.players[1].score
        
        XCTAssertEqual(100, scoreAfter)
    }
    
    func testTurnIsOver_Player1HasGuessedTwice_ScoreIncreases() {
        multiplayerGame.turnIsOver(score: 150)
        multiplayerGame.turnIsOver(score: 0)
        multiplayerGame.turnIsOver(score: 100)
        
        let scoreAfter = multiplayerGame.players[0].score
        
        XCTAssertEqual(250, scoreAfter)

    }
    
    func testGetPlayerToGuess_Start_Player1() {
        let playerToGuess = multiplayerGame.getPlayerToGuess()
        
        XCTAssertEqual(playerToGuess, multiplayerGame.players[0])
    }
    
    func testGetPlayerToChooseWord_Start_Player2() {
        let playerToChoose = multiplayerGame.getPlayerToChooseWord()
        
        XCTAssertEqual(playerToChoose, multiplayerGame.players[1])
    }
    
    func testGetPlayerToGuess_AfterOneTurn_Player2() {
        multiplayerGame.turnIsOver(score: 0)
        let playerToGuess = multiplayerGame.getPlayerToGuess()
        
        XCTAssertEqual(playerToGuess, multiplayerGame.players[1])
    }
    
    func testGetPlayerToChooseWord_AfterOneTurn_Player1() {
        multiplayerGame.turnIsOver(score: 0)
        let playerToChoose = multiplayerGame.getPlayerToChooseWord()
        
        XCTAssertEqual(playerToChoose, multiplayerGame.players[0])
    }

    
    func testIsGameOver_AllTurnsPlayed_True() {
        for _ in 1...multiplayerGame.totalTurns { multiplayerGame.turnIsOver(score: 0) }
        
        let isGameOver = multiplayerGame.gameIsOver()
        XCTAssertTrue(isGameOver)
    }
    
    func testIsGameOver_OneTurnPlayed_False() {
        multiplayerGame.turnIsOver(score: 0)
        let isGameOver = multiplayerGame.gameIsOver()
        XCTAssertFalse(isGameOver)
    }
}
