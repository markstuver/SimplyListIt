//
//  ItemDetailViewController.swift
//  Simply List It
//
//  Created by Mark Stuver on 8/8/15.
//  Copyright (c) 2015 Mark Stuver. All rights reserved.
//

import UIKit

// Creating Protocols that will be required when any other VC wants to use the ItemDetailViewControllerDelegate
protocol ItemDetailViewControllerDelegate: class {
    
    // Method will be called when the user presses cancel
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController)
    
    // Method will be called to pass the data from the ItemDetailViewController to the requesting VC
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ListItem)
    
    //Method will be called when user is done editing the item so that the data can be changed when the delegate dismisses the VC
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ListItem)
}




/* Making ItemDetailViewController a Delegate for the TextField - 3 steps:
1. Declare the VC as a delegate - ie: add UITextFieldDelegate into the opening Class line
2. Tell the TextField its a Delegate - ie: in Storyboard, select textField and open connection inspector. Ctrl/Click the Outlet Delegate and drag to the ViewController
3. Implement the delegate method */


// Adding UITextFieldDelegate to utilize one of the delegate methods

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {

    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBOutlet weak var addItemTextField: UITextField!
    
    var itemToEdit: ListItem?

// ItemDetailViewControllerDelegate varaiable that will be used to pass data
    weak var delegate: ItemDetailViewControllerDelegate?
    
    
    
    // ViewDidLoad - Change View's name to edit
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 44
        
        if let item = itemToEdit {
            
            title = "Edit Item"
            addItemTextField.text = item.text
            
            doneBarButton.enabled = true
        }
    }
    
    
    
    
    
    
    
    
    
    
    // ViewController receives this message just before it becomes visible
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        // BecomeFirstResponder will make the keyboard automatically show when the window
        addItemTextField.becomeFirstResponder()
    }
    
    
    
    
    
    
    
    
    
    //MARK: -- TableView - Delegate Methods
    
    
    // WILL SELECT ROW AT INDEXPATH
    // Override this method and return nil - this will remove the gray highlight that shows when a row is touched
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        return nil
    }
    
    
    
    //MARK: -- Action Button Methods
    
    //MARK: CANCEL BUTTON
    @IBAction func cancel() {
        
        //Dismiss the AddItemVC view
        //dismissViewControllerAnimated(true, completion: nil)
        
        // ***This code replaces the code above because it will be preformed when the delegate is called.
        // ItemDetailViewControllerDelegate method that will be called when buttom is pressed.
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    
    //MARK: DONE BUTTON
    @IBAction func done() {
        
        // if item is not nil
        if let item = itemToEdit {
            
            //... change text to edited text
            item.text = addItemTextField.text
            
            //call the delegate method to finish.
            delegate?.itemDetailViewController(self, didFinishEditingItem: item)
        
        // then item is nil so treat as a new item
        } else {
            
        // instance of ListItem
        let item = ListItem()
        
        // set Item's text to equal what was entered
        item.text = addItemTextField.text
        // set Item's checkmark to false
        item.checked = false
        
//        //Dismiss the AddItemVC view
//        dismissViewControllerAnimated(true, completion: nil)
        
        // ***This code replaces the code above because the now a delegate method will be called to pass data.
        // ItemDetailViewControllerDelegate method that will be called when buttom is pressed - will pass data
        delegate?.itemDetailViewController(self, didFinishAddingItem: item)
        }
    }
    
    
    
    
    //MARK: -- TextField Delegate Methods (Make sure the add UITextFieldDelegate to the class declaration on the first line of code.
    
    //MARK: Method is invoked every time the user changes the text
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        // What is the old text
        let oldText: NSString = textField.text
        
        // Call textField Delegate Method - Looks for and replaces
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        
//        // **Make sure that field is empty
//        if newText.length > 0 {
//            doneBarButton.enabled = true
//        }
//        else {
//            doneBarButton.enabled = false
//        }
        
        // Make sure that the field is empty.  **SIDE NOTE: his replaces the If Else statement that is commented above.
        doneBarButton.enabled = (newText.length > 0)
        
        return true
    }

}
