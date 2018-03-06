//  ViewController.swift
//  Concentration
//
//  Created by CS193p Instructor  on 09/25/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//
//

import UIKit

class ConcentrationViewController: VCLLoggingViewController {
	
    override var vclLoggingName: String {
        return "Game"
    }
    
	private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
	
	var numberOfPairsOfCards: Int {
		return (cardButtons.count + 1) / 2
	}
	
	private(set) var flipCount = 0 {
		didSet {
			let attributes: [NSAttributedStringKey: Any] = [
				.strokeWidth: 5.0,
				.strokeColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
			]
			let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
			flipCountLabel.attributedText = attributedString
		}
	}
	
	@IBOutlet private weak var flipCountLabel: UILabel! {
		didSet {
			flipCount = 0
		}
	}
	
	@IBOutlet private var cardButtons: [UIButton]!
	
	
	@IBAction private func touchCard(_ sender: UIButton) {
		flipCount += 1
		if let cardNumber = cardButtons.index(of: sender) {
			game.chooseCard(at: cardNumber)
			updateViewFromModel()
		} else {
			print("choosen card was not in cardButtons")
		}
	}
	
	private func updateViewFromModel() {
		guard cardButtons != nil else { return }
		for index in cardButtons.indices {
			let button = cardButtons[index]
			let card = game.cards[index]
			if card.isFaceUp {
				button.setTitle(emoji(for: card), for: UIControlState.normal)
				button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
			} else {
				button.setTitle("", for: UIControlState.normal)
				button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
			}
		}
		
	}
	
	var theme: String? {
		didSet {
			emojiChoices = theme ?? ""
			emoji = [:]
			updateViewFromModel()
		}
	}
	
	private var emojiChoices = "🦇😱🙀😈🎃👻🍭🍬🍎"
	
	private var emoji = [Card: String]()
	
	private func emoji(for card: Card) -> String {
		if emoji[card] == nil, emojiChoices.count > 0 {
			let stringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4Random)
			emoji[card] = String(emojiChoices.remove(at: stringIndex))
		}
		return emoji[card] ?? "?"
	}
}

extension Int {
	var arc4Random: Int {
		switch self {
		case 1...Int.max:
			return Int(arc4random_uniform(UInt32(self)))
		case -Int.max..<0:
			return Int(arc4random_uniform(UInt32(self)))
		default:
			return 0
		}
		
	}
}














