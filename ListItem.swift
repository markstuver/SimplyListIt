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
    
    
    // NSCoding Protocol Methods
    
    // This function tells NSCoder what specific items need to be saved from this object/item
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: "Text")
        aCoder.encodeBool(checked, forKey: "Checked")
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init()
    }

}