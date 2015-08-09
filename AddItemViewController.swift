//
//  AddItemViewController.swift
//  Simply List It
//
//  Created by Mark Stuver on 8/8/15.
//  Copyright (c) 2015 Mark Stuver. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {

    
    
    
    
    
    
    
    
    
    
    
    //MARK: -- TableView - Delegate Methods
    
    
    // WILL SELECT ROW AT INDEXPATH
    // Override this method and return nil - this will remove the gray highlight that shows when a row is touched
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        return nil
    }
    
    
    
    //MARK: -- Action Button Methods
    
    //MARK: CANCEL BUTTON
    @IBAction func cancel() {
        
        // Dismiss the AddItemVC view
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    //MARK: DONE BUTTON
    @IBAction func done() {
        
        //Dismiss the AddItemVC view
        dismissViewControllerAnimated(true, completion: nil)
    }

}
