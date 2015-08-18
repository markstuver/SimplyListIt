//
//  ListItem.swift
//  Simply List It
//
//  Created by Mark Stuver on 8/8/15.
//  Copyright (c) 2015 Mark Stuver. All rights reserved.
//

import Foundation

class ListItem: NSObject, NSCoding {
    
    var text = ""
    var checked = false
    
    // Class method
    func toggleChecked() {
        
        // take value of checked and make it the opposite value
        checked = !checked
    }
    
    
/* SAVE & LOAD - NSCoding Protocol Methods
    
**First you need to conform the class to the NSCoding Protocol**
    
    * Go to the top of the page where the class name is created
    ** Add NSCoding so that the class conforms to the NSCoding protocol
    *** ie:
    
class ObjectItem: NSCoding {
    
// SAVING - This protocol function method tells NSCoder what specific items need to be saved from this object/item */
    func encodeWithCoder(aCoder: NSCoder) {
        
        // take the text property value and create an ecodeObject called Text
        aCoder.encodeObject(text, forKey: "Text")
        // take the checked property value and create an ecodeBool called Checked
        aCoder.encodeBool(checked, forKey: "Checked")
        
    }
    
// LOADING - This protocol function method is called to load the encoded data back into the app
    required init(coder aDecoder: NSCoder) {
        
        // load the text info in the "Text" codedObject back into the text property
        text = aDecoder.decodeObjectForKey("Text") as! String
        // load the checked info in the "Checked" codedBool back into the checked property
        checked = aDecoder.decodeBoolForKey("Checked")
        
        super.init()
    }
    
    
    
    override init() {
        
        super.init()
    }

}