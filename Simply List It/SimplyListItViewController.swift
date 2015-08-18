//
//  ViewController.swift
//  Simply List It
//
//  Created by Mark Stuver on 8/8/15.
//  Copyright (c) 2015 Mark Stuver. All rights reserved.
//

import UIKit

class SimplyListItViewController: UITableViewController, ItemDetailViewControllerDelegate {
    
    
    var items: [ListItem]
    
    
    required init(coder aDecoder: NSCoder) {
        
        items = [ListItem]()
        
        super.init(coder: aDecoder)
        
        loadSimplyListItItem()
  
        
/*      code below was original used as sample list items while creating the methods to all of adding/editing/deleting list items.
        
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
*/
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
        
        // encode item and save
        saveSimplyListItItem()

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
        
        // encode item and save
        saveSimplyListItItem()

    }
    
    
    
    //MARK: -- ItemDetailViewController - DELEGATE Methods
    
    
    // When AddItem's Cancel Button is pressed - this delegate method will trigger
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
        
        // Dismiss the addItemVC
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    // When AddItem's Done Button is pressed - this delegate method is triggered - data is passed and Screen is dismissed.
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ListItem) {
        
        // Grab the new row's index
        let newRowIndex = items.count
        
        // Add the item that was passed into the items Array
        items.append(item)
        
        // Set the indexPath to the new row that the new item will go
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        
        // Create an array with indexPath
        let indexPaths = [indexPath]
        
        // Call tableView method that will insert the new row at the proper indexPath
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
        // Dismiss the addItemVC
        dismissViewControllerAnimated(true, completion: nil)
        
        // encode item and save
        saveSimplyListItItem()

    }
  
    
    
    
    
    // When EditItem's Done Button is pressed - this delegate method is triggered - data is changed and screen is dismissed.
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ListItem) {
        
        if let index = find(items, item) {
            
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                
                configureTextForCell(cell, withListItem: item)
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
        
        // encode item and save
        saveSimplyListItItem()
    }
    
    
    
    //MARK: --- FILE SAVING/LOADING
    
    // Find the document directory (sandbox) for this App
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as! [String]
        return paths[0]
    }
    
    // Using the using the document directory, construct a full path to the file that will store the list's data
    func dataFilePath() -> String {
        
        return documentsDirectory().stringByAppendingPathComponent("Simply_List_It.plist") //Simply_List_It.plist is the filename
    }
    
    
// SAVING data to file
    func saveSimplyListItItem() {
        
        // ** Add NSCoding to the ListItem class to conform to the NSCoding protocol
        
        // Create instance of NSMutableData
        let data = NSMutableData()
        
        // Create archive instant to hold the data being saved
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        
        // encode the items array into the archive instance
        archiver.encodeObject(items, forKey: "ListItems")
        
        // call finishEncoding method on archive instance
        archiver.finishEncoding()
        
        // write the archive instance's data into a file
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    
// LOADING data from file
    func loadSimplyListItItem() {
        
        // Create a temporary instance of the file path
        let path = dataFilePath()
        
        // If the plist file exsists (which means a file was created and data has been saved) - if it doesnot exsist then there is no data to load
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            
            // Make sure there is data actually in the file
            if let data = NSData(contentsOfFile: path) {
                
                // unarchive the array of saved data into a temporary constant
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
            
                // load the array of saved data into the global array variable
                items = unarchiver.decodeObjectForKey("ListItems") as! [ListItem]
                
                // notify that the decoding has completed
                unarchiver.finishDecoding()
            }
        }
    }
    
    
    //MARK: -- Action/Button Methods
 
/* 
    THIS BUTTON METHOD HAS BEEN REPLACED BY THE ItemDetailViewControllerDelegate's PROTOCOL METHODS
            **** REMEMBER TO DOUBLE CHECK THAT IN STORYBOARD THAT THE 'ADD' BUTTON's ONLY CONNECTION SHOULD BE THE SEQUE. */
    
//    @IBAction func addItem() {
//        
//        // Create constant equal to the count of the array (count will give you the next row
//        let newRowIndex = items.count
//        
//        // Create instance of the ListItem Class object
//        let item = ListItem()
//        
//        // Set the new instance's parameters
//        item.text = "I am a new row!"
//        item.checked = false
//
//        // add the item into the array
//        items.append(item)
//        
//        // Create instance of new row's indexPath to add to the tableView
//        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
//        
//        // create new/temporary array holding the new indexPath item
//        let indexPaths = [indexPath]
//        
//        // Insert new row into the tableView - with nice animation
//        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
//        
//    }
    

    
   //MARK: -- Helper Methods
    
    // Configure Checkmark for Cell
    func configureCheckmarkForCell(cell: UITableViewCell, withListItem item: ListItem) {
        
       /*   // If cell's accessory is off... turn it on, if it is on... turn it off
          if item.checked {
        
              cell.accessoryType = .Checkmark
          }
          else {
        
             cell.accessoryType = .None
          }*/

    // *** THE FOLLOWING CODE REPLACED THE COMMENTED OUT CODE ABOVE
        
        let label = cell.viewWithTag(1001) as! UILabel
        
        if item.checked {
            
            label.text = "✓"
            
        } else {
            
            label.text = ""
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
    
    

    //MARK: -- PREPARE FOR SEGUE METHODS
    
    // Prepare For Segue Method - Seguing to a ItemDetailViewController that is on top of a NavigationController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Make sure we are in the correct segue (Must equal segue identifier name in Storyboard)
        if segue.identifier == "AddItem" {
            
            // Make sure that we are sequing into the ItemDetailViewController Class
            if segue.destinationViewController.topViewController is (ItemDetailViewController) {
             
            // Create constant equal to the destinationVC (navigationController) - force unwrapped as UINavigationController
            let navigationController = segue.destinationViewController as! UINavigationController
                
                // Create constant equal the destinationVC's topViewController (force unwrapped as ItemDetailViewController)
                let controller = navigationController.topViewController as! ItemDetailViewController
                
                // Set the ultimate destinationVC's delegate as self
                controller.delegate = self
        }
            
      // else if the segue we need is the EditItem
    } else if segue.identifier == "EditItem" {
            
            // and the destinationVC's topVC is what we want
            if segue.destinationViewController.topViewController is (ItemDetailViewController) {
                
                // Create instance of the destinationVC and force it to be a UINavigationController
                let navigationController = segue.destinationViewController as! UINavigationController
                
                // Create an instance of the topVC of the NavigationController and force it to be AddItemVC
                let controller = navigationController.topViewController as! ItemDetailViewController
                
                // Set the delegate for the topVC instance as self (meaning the VC we are in right now)
                controller.delegate = self
                
                /* The Prepare for Segue method has a parameter called sender. It is initially set as an optional because if we call this method and do not need the parameter, the optional allows for it to read as nil which will let the method continue without error...
                
                So because we need to know which indexPath.row was tapped for edit, we will need to unwrap the sender optional to us the indexPath value inside it.
                
                Since sender could be a nil and we dont want to take any chances... we use an if statement to make sure that the value of sender is indeed the indexPath and not nil.
                
                */
                if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                    
                    controller.itemToEdit = items[indexPath.row]
                }
            }
        }
    }


}


