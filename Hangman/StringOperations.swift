//
//  StringOperations.swift
//  Hangman
//
//  Created by Julia Friberg on 2017-06-21.
//  Copyright © 2017 Julia Friberg. All rights reserved.
//

import Foundation

extension String {
    
    func count() -> Int {
        return characters.count
    }
    
    func indices(of characterToFind: Character) -> [Int] {
        var indices: [Int] = []
        
        for (index, currentCharacter) in lowercased().characters.enumerated() {
            if currentCharacter == characterToFind {
                indices += [index]
            }
        }
        return indices
    }
    
    func replace(at indices: [Int], with character: Character) -> String {
        return String(characters.enumerated().map { (index, char) -> Character in
            return indices.contains(index) ? character : char
        })
    }
    
    func charactersOnlyInGivenString(_ givenString: String) -> [Character] {
        let originalCharacterSet = Set(lowercased().characters)
        let givenCharacterSet = Set(givenString.lowercased().characters)
        
        let sameCharacters = originalCharacterSet.intersection(givenCharacterSet)
        
        let charactersOnlyInGivenString = sameCharacters.symmetricDifference(givenCharacterSet)

        return Array(charactersOnlyInGivenString)
    }
}
