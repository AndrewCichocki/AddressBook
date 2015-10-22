//
//  Database.swift
//  AddressBook
//
//  Created by Andrew on 2015-10-21.
//  Copyright © 2015 Andrew Cichocki. All rights reserved.
//

import Foundation

/**
Creates new database on initial run.
*/
func createDatabase() -> Bool {
    let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
    let fileURL = documentsURL.URLByAppendingPathComponent("db.sqlite")
    let path = fileURL.path!
    let database = FMDatabase(path: path)
    if !database.open() {
        print("Error: Unable to open database in function 'createDatabase'")
        return false
    } else if !database.executeUpdate(
        "CREATE TABLE IF NOT EXISTS contacts (contactid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, lastname TEXT NOT NULL, firstname TEXT NOT NULL, cellphone TEXT NOT NULL, homephone TEXT NOT NULL, email TEXT NOT NULL, picture_large TEXT NOT NULL, thumbnail TEXT NOT NULL)",
        withArgumentsInArray: nil) {
            print("Error: SQL command 'create table' failed in  function'createDatabase'.\n'\(database.lastErrorMessage())'.")
            database.close()
            return false
    } else {
        database.close()
        return true
    }
}

/**
Adds new contact to database.
*/
func addContact(lastname: String, firstname: String, cellphone: String, homephone: String, email: String, picture_large: String, thumbnail: String) -> Bool {
    let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
    let fileURL = documentsURL.URLByAppendingPathComponent("db.sqlite")
    let path = fileURL.path!
    let database = FMDatabase(path: path)
    if !database.open() {
        print("Error: Unable to open database in function 'addContact'")
        return false
    } else if !database.executeUpdate(
        "INSERT INTO contacts (lastname, firstname, cellphone, homephone, email, picture_large, thumbnail) values (?, ?, ?, ?, ?, ?, ?)",
    withArgumentsInArray: [lastname, firstname, cellphone, homephone, email, picture_large, thumbnail]) {
            print("Error: SQL command 'insert into' failed in  function'addContact'.\n'\(database.lastErrorMessage())'.")
            database.close()
            return false
    } else {
        database.close()
        return true
    }
}

/**
Retrieves all contacts from database.
*/
func getAllContacts() -> [String: [String: String]] {
    let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
    let fileURL = documentsURL.URLByAppendingPathComponent("db.sqlite")
    let path = fileURL.path!
    let database = FMDatabase(path: path)
    var allContacts = [String: [String: String]]()
    if !database.open() {
        print("Error: Unable to open database in function 'getAllContacts'")
        return allContacts
    } else {
        if let rs = database.executeQuery("SELECT * FROM contacts", withArgumentsInArray: nil) {
            while rs.next() {
                let lastname: String = rs.stringForColumn("lastname")
                let firstname: String = rs.stringForColumn("firstname")
                let fullname: String = "\(firstname) \(lastname)"
                let cellphone: String = rs.stringForColumn("cellphone")
                let homephone: String = rs.stringForColumn("homephone")
                let email: String = rs.stringForColumn("email")
                let picture_large: String = rs.stringForColumn("picture_large")
                let thumbnail: String = rs.stringForColumn("thumbnail")
                allContacts[fullname] = ["cellphone": cellphone, "homephone": homephone, "email": email, "picture_large": picture_large, "thumbnail": thumbnail]
            }
        } else {
            print("select failed: \(database.lastErrorMessage())")
            database.close()
            return allContacts
        }
    }
    database.close()
    return allContacts
}

//TODO: Download & save pictures for each contact
