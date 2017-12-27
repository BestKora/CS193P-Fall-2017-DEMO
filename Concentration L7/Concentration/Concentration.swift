//
//  Concentration.swift
//  Lecture 4 - Concentration
//
//  Created by CS193p Instructor  on 09/25/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//
//

import Foundation

class Concentration {
	
	private(set) var cards = [Card]()
	private var indexOfOneAndOnlyFaceUpCard: Int? {
		get {
			return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
		}
		set {
			for index in cards.indices {
				cards[index].isFaceUp = (index == newValue)
			}
		}
				
	}
	
	func chooseCard(at index: Int) {
		assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) : Choosen index out of range")
		if !cards[index].isMatched {
			if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
				// check if cards match
				if cards[matchIndex] == cards[index] {
					cards[matchIndex].isMatched = true
					cards[index].isMatched = true
				}
				cards[index].isFaceUp = true
			} else {
				indexOfOneAndOnlyFaceUpCard = index
			}
		}
	}
	
	init(numberOfPairsOfCards: Int) {
		assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)) : You must have at least one pair of cards")
		for _ in 1...numberOfPairsOfCards {
			let card = Card()
			cards += [card, card]
		}
	//	TODO: Shuffle the cards
	}
}

extension Collection {
	var oneAndOnly: Element? {
		return count == 1 ? first : nil
	}
}




