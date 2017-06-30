//
//  Highscore.swift
//  Hangman
//
//  Created by Julia Friberg on 2017-06-28.
//  Copyright © 2017 Julia Friberg. All rights reserved.
//

import Foundation

class Highscore {
    
    static let key = "Highscore"
    
    
    static func set(highscore: Int) {
        UserDefaults.standard.set(highscore, forKey: key)
    }
    
    static func get() -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }
    
    static func isHighscore(_ score: Int) -> Bool {
        let highscore = get()
        return score > highscore
    }
}


