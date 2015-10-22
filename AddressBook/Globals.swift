//
//  Globals.swift
//  AddressBook
//
//  Created by Andrew on 2015-10-21.
//  Copyright © 2015 Andrew Cichocki. All rights reserved.
//

import Foundation

class Globals {
    struct Variables {
        static var allContacts = [String: [String: String]]()
        static var sortedKeys = [String]()
    }
}

/**
Sorts keys (fullname) of allContacts array alphabetically to be displayed in TableViewController.
*/
func sortKeys() {
    Globals.Variables.sortedKeys = Array(Globals.Variables.allContacts.keys).sort(<)
    NSNotificationCenter.defaultCenter().postNotificationName("reload", object: nil)
}