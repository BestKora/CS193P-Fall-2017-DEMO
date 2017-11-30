//
//  ViewController.swift
//  PlayingCard
//
//  Created by CS193p Instructor on 10/9/17.
//  Copyright © 2017 CS193p Instructor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...10 {
            if let card = deck.draw() {
                print("\(card)")
            }
        }
    }

}

