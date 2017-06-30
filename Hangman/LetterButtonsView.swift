
import UIKit

class LetterButtonsView: UIView {
        
    var buttons: [UIButton] = []
    
    var animator: UIDynamicAnimator?
    let gravity = UIGravityBehavior(items: [])
    let collision = UICollisionBehavior(items: [])
    var actionTarget: GameViewController?
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpGravityAnimation()
    }
    
    func setUpGravityAnimation() {
        animator = UIDynamicAnimator(referenceView: self)
        
        let vector = CGVector(dx: 0.0, dy: 0.5)
        gravity.gravityDirection = vector
        
        collision.translatesReferenceBoundsIntoBoundary = true
        
        animator?.addBehavior(collision)
        animator?.addBehavior(gravity)
    }
    
    func createButtons(letters: String, actionTarget: GameViewController) {
        self.actionTarget = actionTarget
        
        for character in letters.characters {
            let button = createButton(with: character)
            buttons += [button]
        }
        
        let buttonsByRow = stride(from: 0, to: buttons.count, by: 6).map({ (startIndex) -> [UIButton] in
            let endIndex = (startIndex.advanced(by: 6) > buttons.count) ? buttons.count-startIndex : 6
            return Array(buttons[startIndex..<startIndex.advanced(by: endIndex)])
        })
        
        let generalStackView = UIStackView()
        generalStackView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height*0.6)
        generalStackView.distribution = .equalSpacing
        generalStackView.axis = .vertical
        
        for row in buttonsByRow {
            let rowStackView = UIStackView()
            rowStackView.alignment = .fill
            rowStackView.distribution = .equalSpacing
            rowStackView.axis = .horizontal
            
            for button in row { rowStackView.addArrangedSubview(button) }
            
            generalStackView.addArrangedSubview(rowStackView)
        }
        addSubview(generalStackView)
    }
    
    private func createButton(with character: Character) -> UIButton {
        let button = UIButton()
        button.setTitle("\(character)".uppercased(), for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(24)
        button.setTitleColor(tintColor, for: .normal)
        button.setTitleColor(.lightGray, for: .disabled)
        button.accessibilityIdentifier = "\(character)"
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        return button
    }
    
    func buttonTapped(_ sender: UIButton) {
        guard let letterIdentifier = sender.accessibilityIdentifier,
            let letter = letterIdentifier.characters.first else {
                print("Button had no identifier")
                return
        }
        actionTarget?.guessLetter(letter)
        animateGuess(on: sender)
    }
    
    func resetButtons() {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
            for item in self.gravity.items { self.gravity.removeItem(item) }
            for item in self.collision.items { self.collision.removeItem(item) }
     
            for button in self.buttons {
                button.isEnabled = true
                button.transform = CGAffineTransform(a: 1.0, b: 0.0, c: 0.0, d: 1.0, tx: 0.0, ty: 0.0)
            }
        })
     }
     
     func animateGuess(on button: UIButton) {
        button.isEnabled = false
        gravity.addItem(button)
        collision.addItem(button)
     }
}
