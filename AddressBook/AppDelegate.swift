//
//  AppDelegate.swift
//  AddressBook
//
//  Created by Andrew on 2015-10-21.
//  Copyright © 2015 Andrew Cichocki. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Create database
        if createDatabase() == true {
            // Add existing contacts to global variable
            Globals.Variables.allContacts = getAllContacts()
            if Globals.Variables.allContacts.count < 20 {
                // Download contacts if not enough
                pullData(20)
            }
            // Sort contacts alphabetically
            sortKeys()
        }
        return true
    }

}

