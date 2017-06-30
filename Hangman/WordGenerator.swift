//
//  WordGenerator.swift
//  Hangman
//
//  Created by Julia Friberg on 2017-06-22.
//  Copyright © 2017 Julia Friberg. All rights reserved.
//

import Foundation

class WordGenerator {
    static func generate() -> String {
        if let wordsFilePath = Bundle.main.path(forResource: "wordlist", ofType: ".txt") {
            do {
                let wordsString = try String(contentsOfFile: wordsFilePath)
                
                let wordLines = wordsString.components(separatedBy: .newlines)
                
                let randomLine = wordLines[numericCast(arc4random_uniform(numericCast(wordLines.count)))]
                
                return randomLine
                
            } catch { // contentsOfFile throws an error
                print("Error: \(error)")
            }
        }
        return ""
    }
}
