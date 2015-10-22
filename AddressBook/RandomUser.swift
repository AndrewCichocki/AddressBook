//
//  RandomUser.swift
//  AddressBook
//
//  Created by Andrew on 2015-10-21.
//  Copyright © 2015 Andrew Cichocki. All rights reserved.
//

import Foundation

/**
Downloads random user data to store in database.
*/
func pullData(results: Int) {
    let limit: Int
    if results >= 1 && results <= 2000 {
        limit = results
    } else {
        limit = 20
    }
    let url = NSURL(string: "http://api.randomuser.me/?results=\(limit)")
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithURL(url!) { (data, response, error) -> Void in
        //Block starts
        if data != nil {
            do {
                let rawJson = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
                if let results = rawJson["results"] as? NSArray {
                    for var i = 0; i < results.count; i++ {
                        if let user = results[i]["user"] as? NSDictionary {
                            if let lastname = user["name"]?["last"] as? String,
                                firstname = user["name"]?["first"] as? String,
                                cellphone = user["cell"] as? String,
                                homephone = user["phone"] as? String,
                                email = user["email"] as? String,
                                picture_large = user["picture"]?["large"] as? String,
                                thumbnail = user["picture"]?["thumbnail"] as? String {
                                    //add to db
                                    if addContact(lastname,
                                        firstname: firstname,
                                        cellphone: cellphone,
                                        homephone: homephone,
                                        email: email,
                                        picture_large: picture_large,
                                        thumbnail: thumbnail) == true {
                                        print("'\(firstname) \(lastname)' added to contacts")
                                    } else {
                                        print("Error: Could not add '\(firstname) \(lastname)' to contacts in function 'pullData'")
                                    }
                            } else {
                                print("Error: optionals could not be unwrapped in function 'pullData'")
                            }
                        }
                    }
                }
                
            } catch {
                // If 'try NSJSONSerialization' throws an exception
                print("Error: JSON data could not be saved in function 'pullData'")
                return
            }
            // End of 'if data != nil'
        } else {
            // If data was nil display error, prevent crash
            print("Error: object 'data' is nil in function 'pullData', possible connectivity issue.")
        }
        //Block ends
    }
    //Execute network request
    task.resume()
}