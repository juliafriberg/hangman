//
//  StringOperationsTests.swift
//  Hangman
//
//  Created by Julia Friberg on 2017-06-21.
//  Copyright © 2017 Julia Friberg. All rights reserved.
//

import XCTest
@testable import Hangman

class StringOperationsTests: XCTestCase {
    
    let longWord = "TestedWord"
    let shortWord = "word"
    
    func testNumberOfCharacters_ShortWord() {
        let numberOfCharacters = shortWord.numberOfCharacters()
        
        XCTAssertEqual(4, numberOfCharacters)
    }
    
    func testNumberOfCharacters_LongWord() {
        let numberOfCharacters = longWord.numberOfCharacters()
        
        XCTAssertEqual(10, numberOfCharacters)
    }


    func testIndexOfCharacter_SecondCharacter() {
        let index = shortWord.index(of: "o")
        
        XCTAssertEqual([1], index)
    }
    
    func testIndexOfCharacter_FirstCharacter() {
        let index = shortWord.index(of: "w")
        
        XCTAssertEqual([0], index)
    }
    
    func testIndexOfCharacter_RecurringCharacter_ListOfIndices() {
        let index = longWord.index(of: "t")
        
        XCTAssertEqual([0,3], index)
    }
    
    func testReplacing_AtFirstIndexWithH() {
        let index = [0]
        
        let replacedWord = longWord.replacing(at: index, with: "H")
        
        XCTAssertEqual("HestedWord", replacedWord)
        
    }
    
    func testReplacing_AtSeveralIndicesWithH() {
        let index = [0,3]
        
        let replacedWord = longWord.replacing(at: index, with: "H")
        
        XCTAssertEqual("HesHedWord", replacedWord)
        
    }
    
    func testCharactersNotInString() {
        let firstWord = "Word1"
        let secondWord = "AnotherWord"
        
        let differingCharacters = firstWord.charactersNotInString(from: secondWord)
        
        XCTAssertEqual(["a", "n", "t", "h", "e"].sorted(), differingCharacters.sorted())
    }
}
