//
//  StringOperations.swift
//  Hangman
//
//  Created by Julia Friberg on 2017-06-21.
//  Copyright © 2017 Julia Friberg. All rights reserved.
//

import Foundation

extension String {
    
    func numberOfCharacters() -> Int {
        return characters.count
    }
    
    func index(of character: Character) -> [Int] {
        var indices: [Int] = []
        
        
        for (index, char) in lowercased().characters.enumerated() {
            if char == character {
                indices += [index]
            }
        }
        return indices
    }
    
    func replacing(at indices: [Int], with character: Character) -> String {
        return String(characters.enumerated().map { (index, char) -> Character in
            return indices.contains(index) ? character : char
        })
    }
    
    func charactersNotInString(from word: String) -> [Character] {
        let characterSet = Set(lowercased().characters)
        let wordCharacterSet = Set(word.lowercased().characters)
        
        let sameCharacters = characterSet.intersection(wordCharacterSet)
        
        let charactersOnlyInWord = sameCharacters.symmetricDifference(wordCharacterSet)

        return Array(charactersOnlyInWord)
    }
}
