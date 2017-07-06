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
        let numberOfCharacters = shortWord.count()
        
        XCTAssertEqual(4, numberOfCharacters)
    }
    
    func testNumberOfCharacters_LongWord() {
        let numberOfCharacters = longWord.count()
        
        XCTAssertEqual(10, numberOfCharacters)
    }


    func testIndexOfCharacter_SecondCharacter() {
        let indices = shortWord.indices(of: "o")
        
        XCTAssertEqual([1], indices)
    }
    
    func testIndexOfCharacter_FirstCharacter() {
        let indices = shortWord.indices(of: "w")
        
        XCTAssertEqual([0], indices)
    }
    
    func testIndexOfCharacter_RecurringCharacter_ListOfIndices() {
        let indices = longWord.indices(of: "t")
        
        XCTAssertEqual([0,3], indices)
    }
    
    func testReplacing_AtFirstIndexWithH() {
        let indices = [0]
        
        let replacedWord = longWord.replace(at: indices, with: "H")
        
        XCTAssertEqual("HestedWord", replacedWord)
        
    }
    
    func testReplacing_AtSeveralIndicesWithH() {
        let indices = [0,3]
        
        let replacedWord = longWord.replace(at: indices, with: "H")
        
        XCTAssertEqual("HesHedWord", replacedWord)
        
    }
    
    func testCharactersNotInString() {
        let firstWord = "Word1"
        let secondWord = "AnotherWord"
        
        let differingCharacters = firstWord.charactersOnlyInGivenString(secondWord)
        
        XCTAssertEqual(["a", "n", "t", "h", "e"].sorted(), differingCharacters.sorted())
    }
}
