//
//  FoodCollectionViewController.swift
//  FoodForThought
//
//  Created by CS193p Instructor.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import UIKit

class FoodCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout
{
    private var useSections = true
    
    // convenience method
    // returns the proper food at a given IndexPath (item number and section)
    // based on whether useSections is turned on
    private func food(at indexPath: IndexPath) -> String {
        if useSections {
            let category = FoodModel.categories[indexPath.section]
            return FoodModel.food[category]?[indexPath.item] ?? ""
        } else {
            return FoodModel.all[indexPath.item]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setting the following means to calculate cell size using autolayout
        // make sure that the top-level view in your custom cell is a generic UIView
        // and that it is pinned to the edges of the cell
        // put all the rest of your custom cell UI into the generic UIView
        // and set up autolayout so that the size of the generic UIView is forced to be what you want
        flowLayout?.itemSize = UICollectionViewFlowLayoutAutomaticSize
        flowLayout?.estimatedItemSize = CGSize(width: 100, height: 120)
    }
    
    // this is a useful var to define
    // it lets you get at the default flow layout for a collection view
    private var flowLayout: UICollectionViewFlowLayout? {
        return collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
    }
    
    // uncomment this if you want to control the cell size via code
    // if you want to get this to "escape complete" as you're typing it in
    //   your UICollectionViewController will have to say
    //   that it implements the UICollectionViewDelegateFlowLayout protocol
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        return CGSize
    //    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return useSections ? FoodModel.categories.count : 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if useSections {
            let category = FoodModel.categories[section]
            return FoodModel.food[category]?.count ?? 0
        } else {
            return FoodModel.all.count
        }
    }
    
    // this is just like cellForRowAt in UITableView
    // except, in a UICollectionView, the cells are always custom subclasses of UICollectionViewCell
    // (i.e. there is no "Basic" or "Subtitle" style cell like there is in table view)
    // we only have one cell type (FoodCell)
    // but we could have as many different kinds as we want
    // (each with its own different identifier and UICollectionViewCell subclass)
    // see table view code for an example of choosing between dequeueing two different cell types
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath)
    
        // Configure the cell
        if let foodCell = cell as? FoodCollectionViewCell {
            foodCell.nameLabel.text = food(at: indexPath)
            foodCell.emojiLabel.text = FoodModel.emoji[food(at: indexPath)]
        }
    
        return cell
    }
    
    // having a header view for each section is activated by inspecting the UICollectionView in the storyboard
    // and clicking on the "Accessories Section Header" switch
    // this will cause a UICollectionReusableView to appear in the storyboard scene
    // the Identity of the ReusableView is then changed to a custom UICollectionReusableView subclass
    // (in this case "SimpleLabelResusableView")
    // then open the Attributes Inspector on the header view and set its Identifier (in this case "FoodHeader")
    // then implement this method to configure any outlets in the custom subclass
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FoodHeader", for: indexPath)
            if let foodHeader = header as? SimpleLabelReusableView {
                foodHeader.label.text = useSections ? FoodModel.categories[indexPath.section] : "Food"
            }
            return header
        } else {
            assert(false, "FoodCollectionViewController asked for supplementary element of unknown kind \(kind).")
        }
    }
}
