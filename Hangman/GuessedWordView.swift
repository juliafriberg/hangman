//
//  GuessedWordView.swift
//  Hangman
//
//  Created by Julia Friberg on 2017-06-28.
//  Copyright © 2017 Julia Friberg. All rights reserved.
//

import UIKit

class GuessedWordView: UIView {

    var guessedWordLabel: UILabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guessedWordLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        guessedWordLabel.font = guessedWordLabel.font.withSize(32)
        guessedWordLabel.textAlignment = .center
        guessedWordLabel.adjustsFontSizeToFitWidth = true
        guessedWordLabel.minimumScaleFactor = 0.5
        addSubview(guessedWordLabel)
    }
    
    func setText(word: String) {
        guessedWordLabel.text = word
        addSpacing()
    }
    
    func addSpacing() {
        let attributedString = NSMutableAttributedString(string: guessedWordLabel.text!)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(3), range: NSRange(location: 0, length: attributedString.length))
        guessedWordLabel.attributedText = attributedString
    }
}
