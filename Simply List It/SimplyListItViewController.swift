//
//  ViewController.swift
//  Simply List It
//
//  Created by Mark Stuver on 8/8/15.
//  Copyright (c) 2015 Mark Stuver. All rights reserved.
//

import UIKit

class SimplyListItViewController: UITableViewController {
    
    
    var items: [ListItem]
    
    
    required init(coder aDecoder: NSCoder) {
        
        items = [ListItem]()
        
        let row0item = ListItem()
        row0item.text = "Walk the dog"
        row0item.checked = false
        items.append(row0item)
        
        let row1item = ListItem()
        row1item.text = "Brush my teeth"
        row1item.checked = true
        items.append(row1item)
        
        let row2item = ListItem()
        row2item.text = "Eat ice cream"
        row2item.checked = false
        items.append(row2item)
        
        super.init(coder: aDecoder)
    }
    
    
    
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    
    
    //MARK: -- TableView DATASOURCE Methods
   
    
    //MARK: NUMBER of ROWS on SECTION
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Number of Rows in a Section
        
        return items.count
    }
    
    //MARK: CELL for ROW at INDEXPATH
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Set the reusableCellWithIdentifier equal to the name given in cell - Then force cast it as a UITableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("SimplyListItItem") as! UITableViewCell
        
        // Create constant set the the item at the current indexPath/row
        let item = items[indexPath.row]

        // Call the Helper Methods
        // Set the cell's checkmark
        configureCheckmarkForCell(cell, withListItem: item)
        
        // Set the label's text
        configureTextForCell(cell, withListItem: item)
        
        // return instance of cell
        return cell
    }
   
    //MARK: ALLOW USER TO DELETE ROWS
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // remove the item from the ListItem array
        items.removeAtIndex(indexPath.row)
        
        // Creating a temporary Array with indexPaths to be deleted
        let indexPaths = [indexPath]
        
        // Delete the rows in the indexPaths Array
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }

    
    
    
    
    //MARK: -- TableView DELEGATE Methods

    
    //MARK: TURN ON or OFF CHECKMARKS ON CELLS
    // Notifys the delegate that the user is no longer pressing on the cell
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            
            let item = items[indexPath.row]
            
            // Call Class method. Method is located in the ListItem Class
            item.toggleChecked()
            
            configureCheckmarkForCell(cell, withListItem: item)
        }
    
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    //MARK: -- Action/Button Methods
    
    @IBAction func addItem() {
        
        // Create constant equal to the count of the array (count will give you the next row
        let newRowIndex = items.count
        
        // Create instance of the ListItem Class object
        let item = ListItem()
        
        // Set the new instance's parameters
        item.text = "I am a new row!"
        item.checked = false

        // add the item into the array
        items.append(item)
        
        // Create instance of new row's indexPath to add to the tableView
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        
        // create new/temporary array holding the new indexPath item
        let indexPaths = [indexPath]
        
        // Insert new row into the tableView - with nice animation
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
        
    }
    
    
    
    
    
    
    
    
   //MARK: -- Helper Methods
    
    // Configure Checkmark for Cell
    func configureCheckmarkForCell(cell: UITableViewCell, withListItem item: ListItem) {
        
        // If cell's accessory is off... turn it on, if it is on... turn it off
        if item.checked {
            
            cell.accessoryType = .Checkmark
        }
        else {
            
            cell.accessoryType = .None
        }
    }
    
    // Configure Label for Cell
    func configureTextForCell(cell: UITableViewCell, withListItem item:ListItem) {
        
        
        // Tag below equals the numeric tag set to the label UI in Storyboard. Under attribute's inspector/view.
        // The tag is unique and it tells the cell which label is being used.
        // Force cast it as a UILabel.
        let label = cell.viewWithTag(1000) as! UILabel
        
        label.text = item.text
        
    }
    
    

    
    
    
    
    
    
    
    



}

