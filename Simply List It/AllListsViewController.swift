//
//  AllListsViewController.swift
//  Simply List It
//
//  Created by Mark Stuver on 8/24/15.
//  Copyright (c) 2015 Mark Stuver. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController {
    
    
    var lists: [List] // An Array to hold 'List' objects
    
    
    
    required init(coder aDecoder: NSCoder) {
        
        // Create empty Array for List objects
        lists = [List]()
        
        // Call super's version of init(coder) - without this, the view controller won't be properly load a Storyboard.
        super.init(coder: aDecoder)
        
        // Create new List object, give it a name and add to the Array.
        var list = List()
        list.name = "Birthdays"
        lists.append(list)
        
        list = List()
        list.name = "Groceries"
        lists.append(list)
        
        list = List()
        list.name = "Cool Apps"
        lists.append(list)

        list = List()
        list.name = "To Do"
        lists.append(list)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 3
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        
        if cell == nil {
            
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
            
        }
        
        cell.textLabel!.text = "List \(indexPath.row)"
        return cell
    }
    
    
    // MARK: - Table view delegate
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("ShowList", sender: nil)
    }
    

   
}
