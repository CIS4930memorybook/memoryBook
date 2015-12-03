//
//  addFriendsController.swift
//  memoryBook
//
//  Created by Cody Miller on 10/18/15.
//  Copyright © 2015 Cody Miller. All rights reserved.
//

import Foundation
import UIKit
import Parse

class addFriendsController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var AllUsersTableView: UITableView!
    
    var names = [String]()
    
    var selectedUser: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let query = PFQuery(className: "_User")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                print("Gotem")
                
                for image in objects! {
                    self.names.append(image["username"] as! String)
                }
                
                self.AllUsersTableView.reloadData()
                print(self.names)
            }
            else {
                
                print(error)
            }
        }
        //query.findObjectsInBackgroundWithTarget(AnyObject?, selector: <#T##Selector#>)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return names.count
        
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let twoCell: AllViewCell = tableView.dequeueReusableCellWithIdentifier("Cell2") as! AllViewCell
        
        twoCell.Usersname.text = names[indexPath.row]
        
        return twoCell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedUser = names[indexPath.row]
        print(selectedUser)
        
        let friends = PFObject(className: "friends")
        friends["befriender"] = PFUser.currentUser()
        friends["befriended"] = selectedUser
        friends.saveInBackgroundWithBlock {
            (success: Bool, error:NSError?) -> Void in
            
            if(success)
            {
                //We saved our information
                print("New friend made")
                //self.performSegueWithIdentifier("Uploadtoprofile", sender: self)
                
            }
            else
            {
                //there was a problem
                print("Error")
            }
            
            
        }
        
        
        
        
    }

}
