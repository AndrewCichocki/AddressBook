//
//  TableViewController.swift
//  AddressBook
//
//  Created by Andrew on 2015-10-21.
//  Copyright © 2015 Andrew Cichocki. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Should reload after contacts are sorted, but doesn't
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTableData:", name: "reload", object: nil)
        //FIXME: TableView doesn't show new data on initial load
    }
    
    func reloadTableData(notification: NSNotification) {
        tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Globals.Variables.sortedKeys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("addressBookCell", forIndexPath: indexPath)
        let fullname: String = Globals.Variables.sortedKeys[indexPath.row]
        cell.textLabel?.text = fullname
        cell.imageView?.image = UIImage(named: "test-thumbnail.jpg")
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetailSegue"
        {
            if let destinationVC = segue.destinationViewController as? DetailViewController {
                // Send array index of contact's details to next viewcontroller
                destinationVC.key = Globals.Variables.sortedKeys[tableView.indexPathForSelectedRow!.row]
            } else {
                print("Error: Could not unwrap optional in prepareForSegue")
            }
        }
    }
    
}
