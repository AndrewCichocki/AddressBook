//
//  DetailViewController.swift
//  AddressBook
//
//  Created by Andrew on 2015-10-21.
//  Copyright © 2015 Andrew Cichocki. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var key = String()
    var details = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get contact details using index sent from previour viewcontroller
        details = Globals.Variables.allContacts[key]!
        let cellphone: String = details["cellphone"]!
        let email: String = details["email"]!
        // Set view title to fullname (key)
        self.title = key
        
        // Placeholder picture_large
        let imageName = "test-picture-large.jpg"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 60, y: 60, width: 256, height: 256)
        view.addSubview(imageView)
        
        let cellphoneLabel = UILabel(frame: CGRectMake(0, 0, 310, 21))
        cellphoneLabel.center = CGPointMake(160, 340)
        cellphoneLabel.textAlignment = NSTextAlignment.Center
        cellphoneLabel.text = "Cellphone: \(cellphone)"
        self.view.addSubview(cellphoneLabel)
        //TODO: Open phone app when phonenumber is touched
        
        let emailLabel = UILabel(frame: CGRectMake(0, 0, 310, 21))
        emailLabel.center = CGPointMake(160, 370)
        emailLabel.textAlignment = NSTextAlignment.Center
        emailLabel.text = "Email: \(email)"
        self.view.addSubview(emailLabel)
        //TODO: Open email client when email address is touched
    }

}