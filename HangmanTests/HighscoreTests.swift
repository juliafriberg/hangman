
import XCTest
@testable import Hangman

class HighscoreTests: XCTestCase {
    
    func testGetHighScore_Start_0() {
        UserDefaults.blankDefaultsWhile {
            
            let highScore = Highscore.get()
            
            XCTAssertEqual(0, highScore)
        }
    }
    
    func testSetHighScore_200() {
        UserDefaults.blankDefaultsWhile {
            
            Highscore.set(highscore: 200)
            
            XCTAssertEqual(200, UserDefaults.standard.integer(forKey: Highscore.key))
        }
    }
    
    func testGetHighScore_Set500_500() {
        UserDefaults.blankDefaultsWhile {
            
            UserDefaults.standard.set(400, forKey: Highscore.key)
            
            let highscore = Highscore.get()
                
            XCTAssertEqual(400, highscore)
        }
    }
    
    func testHighscoreKey() {
        XCTAssertEqual(Highscore.key, "Highscore")
    }
    
    func testIsHighscore_200_True() {
        UserDefaults.blankDefaultsWhile {
            let isHighscore = Highscore.isHighscore(200)
            XCTAssertTrue(isHighscore)
        }
        
    }
    
    func testIsHighscore_300_False() {
        UserDefaults.blankDefaultsWhile {
            UserDefaults.standard.set(300, forKey: Highscore.key)
            
            let isHighscore = Highscore.isHighscore(200)
            XCTAssertFalse(isHighscore)
        }
        
    }
  
}

extension UserDefaults {
    static func blankDefaultsWhile(handler:()->Void){
        guard let name = Bundle.main.bundleIdentifier else {
            fatalError("Couldn't find bundle ID.")
        }
        let old = UserDefaults.standard.persistentDomain(forName: name)
        defer {
            UserDefaults.standard.setPersistentDomain( old ?? [:],
                                      forName: name)
        }
        UserDefaults.standard.removePersistentDomain(forName: name)
        handler()
    }
}

