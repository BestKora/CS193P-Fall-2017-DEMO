//
//  FoodModel.swift
//  FoodForThought
//
//  Created by CS193p Instructor.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import Foundation

struct FoodModel {
    static var food = [
        "Fruit" : ["Apple","Strawberry","Kiwi"],
        "Vegetable" : ["Carrot","Cucumber"],
        "Dessert" : ["Ice Cream", "Cake", "Candy Bar", "Cookie"],
        "Junk" : ["Pizza","Hamburger","French Fries","Donut"],
        "Breakfast" : ["Bacon","Eggs","Pancakes","Croissant"]
    ]
    
    static var categories: [String] { return Array(food.keys) }
    static var all: [String] { return food.flatMap { $0.value } }
    
    static let emoji = [
        "Apple" : "🍎",
        "Strawberry" : "🍓",
        "Kiwi" : "🥝",
        "Carrot" : "🥕",
        "Cucumber" : "🥒",
        "Ice Cream" : "🍦",
        "Cake" : "🍰",
        "Candy Bar" : "🍫",
        "Cookie" : "🍪",
        "Pizza" : "🍕",
        "Hamburger" : "🍔",
        "French Fries" : "🍟",
        "Donut" : "🍩",
        "Bacon" : "🥓",
        "Eggs" : "🍳",
        "Pancakes" : "🥞",
        "Croissant" : "🥐"
    ]
    
    static let descriptions = [
        "Apple" : "Very delicious food (at least the red ones are).  Doesn't fall far from the tree.",
        "Strawberry" : "Found in fields forever and ever.  Makes a good pie.",
        "Kiwi" : "Invented in New Zealand?  Lots and lots of little seeds in this thing.",
        "Ice Cream" : "You scream, we all scream for it.  Best served cold.",
        "Cake" : "Let them eat it.  Because it's really good.  Not so good for you maybe."
    ]
    
    static func category(of foodName: String) -> String {
        for category in Array(FoodModel.food.keys) {
            if FoodModel.food[category]?.contains(foodName) ?? false {
                return category
            }
        }
        return ""
    }
    
    static func delete(_ foodName: String) {
        for category in categories {
            if let index = food[category]?.index(of: foodName) {
                food[category]?.remove(at: index)
            }
        }
    }
}
