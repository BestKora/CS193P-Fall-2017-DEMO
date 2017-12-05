//
//  FoodCollectionViewCell.swift
//  FoodForThought
//
//  Created by CS193p Instructor.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import UIKit

class FoodCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            layer.borderWidth = isSelected ? 1.0 : 0.0
        }
    }
}
