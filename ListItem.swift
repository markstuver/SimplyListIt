//
//  ListItem.swift
//  Simply List It
//
//  Created by Mark Stuver on 8/8/15.
//  Copyright (c) 2015 Mark Stuver. All rights reserved.
//

import Foundation

class ListItem {
    
    var text = ""
    var checked = false
    
    // Class method
    func toggleChecked() {
        
        // take value of checked and make it the opposite value
        checked = !checked
    }

}