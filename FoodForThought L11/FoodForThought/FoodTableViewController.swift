//
//  FoodTableViewController.swift
//  FoodForThought
//
//  Created by CS193p Instructor.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import UIKit

class FoodTableViewController: UITableViewController
{
    private var useSections = true          // whether to use sections in the table
    
    // convenience methods
    // returns the proper food (or emoji) at a given IndexPath (row and section)
    // based on whether useSections is turned on

    private func food(at indexPath: IndexPath) -> String {
        if useSections {
            let category = FoodModel.categories[indexPath.section]
            return FoodModel.food[category]?[indexPath.row] ?? ""
        } else {
            return FoodModel.all[indexPath.row]
        }
    }
    
    private func emoji(at indexPath: IndexPath) -> String {
        return FoodModel.emoji[food(at: indexPath)] ?? " "
    }
    
    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return useSections ? FoodModel.categories.count : 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if useSections {
            let category = FoodModel.categories[section]
            return FoodModel.food[category]?.count ?? 0
        } else {
            return FoodModel.all.count
        }
    }
    
    // this table has two different kinds of cells in it
    // one (identifier FoodCell) is using the built-in styles for its cells
    // try changing the cell style to Subtitle, Right Detail, Left Detail or Basic and see what happens!
    // the other cell type (identifier CustomFoodCell) is a custom cell
    // we dequeue the right type of cell based on whether the food has a detailed description
    // but obviously you can choose which cell you want using any criteria you like
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
      
        let foodName = food(at: indexPath)

        if (FoodModel.descriptions[food(at: indexPath)]?.count ?? 0) > 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "CustomFoodCell", for: indexPath)
            // Configure the cell...
            if let customCell = cell as? DetailedFoodTableViewCell {
                customCell.name.text = foodName
                customCell.emoji.text = emoji(at: indexPath)
                customCell.category.text = "Category: " + FoodModel.category(of: foodName)
                customCell.details.text = FoodModel.descriptions[foodName]
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath)
            // Configure the cell...
            cell.textLabel?.text = foodName
            cell.detailTextLabel?.text = emoji(at: indexPath)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return useSections ? FoodModel.categories[section] : nil
    }

    /*
     // Override to support conditional editing of the table view.
     // the default is "true", so no need to uncomment this if that's what you want
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    // Override to support editing the table view.
    // We only support the editingStyle of deleting in our food table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            FoodModel.delete(food(at: indexPath))
            // Now tell the table view that these rows went away
            // The Model MUST be in sync with the new state of affairs before you call this!
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // MARK: - UITableViewDataSource

    // there are a number of ways to control the height of each row in a table view ...
    //
    // 1. set the height in the Attributes Inspector in the storyboard (that's how this table's heights are set)
    // 2. set the rowHeight var
    // 3. set the estimatedRowHeight var to something sensible and set rowHeight to UITableViewAutomaticDimension
    // 4. implement the commented-out method below (heightForRowAt)
    //
    // if you choose option 2, the height will be calculated using autolayout
    // (that only makes sense for custom UITableViewCell subclasses, of course)

//  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//      return CGFloat
//  }

    // MARK: - Navigation
    
    // we don't navigate from this MVC
    // but this is conceptually what a prepare(for segue:) might look like

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            if segue.identifier == "Segue Identifier" {
//              if let destination = segue.destination as? MyViewController {
                    let foodName = food(at: indexPath)
                    /* prepare destination with the chosen food */
                    segue.destination.title = foodName
//              }
            }
        }
    }
}
