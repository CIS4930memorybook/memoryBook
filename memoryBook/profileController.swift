//
//  profileController.swift
//  memoryBook
//
//  Created by Cody Miller on 10/18/15.
//  Copyright © 2015 Cody Miller. All rights reserved.
//

//
//  firstViewController.swift
//  MillerCodyAssignment4
//
//  Created by Cody Miller on 10/23/15.
//  Copyright © 2015 Cody Miller. All rights reserved.
//

import UIKit
import Parse

class profileController: UIViewController, UITableViewDelegate {
    //@IBOutlet weak var tableView: UITableView!
    //var images = [PFFile]()
    
    @IBOutlet weak var friendTable: UITableView!
    @IBOutlet weak var profileMemoryTable: UITableView!
    
    var imageFiles = [PFFile]()
    var descriptions = [String]()
    
    var friends = [String]()
    var selectedUser: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let query = PFQuery(className: "memory")
        query.orderByDescending("createdAt")
        query.whereKey("userName", equalTo: (PFUser.currentUser())!)
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                print("worked")
                
                for image in objects! {
                    self.imageFiles.append(image["imageFile"] as! PFFile)
                    self.descriptions.append(image["desc"] as! String)
                }
                print(self.imageFiles.count)
                self.profileMemoryTable.reloadData()
            }
            else {
                
                print(error)
            }
        }
        //query.findObjectsInBackgroundWithTarget(AnyObject?, selector: <#T##Selector#>)
        
        let query2 = PFQuery(className: "friends")
        query2.orderByDescending("createdAt")
        query2.whereKey("befriender", equalTo: (PFUser.currentUser())!)
        query2.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                print("Gotem")
                
                for image in objects! {
                    self.friends.append(image["befriended"] as! String)
                }
                
                self.friendTable.reloadData()
                print(self.friends)
            }
            else {
                
                print(error)
            }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(tableView == self.profileMemoryTable){
            return imageFiles.count
        }
        else{
            return friends.count
        }
        
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(tableView == self.profileMemoryTable){
            
            
            
            let oneCell: MemoryViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! MemoryViewCell
            
            //text
            oneCell.TheDesc.text = descriptions[indexPath.row]
            
            //image
            imageFiles[indexPath.row].getDataInBackgroundWithBlock{(imageData: NSData?, error: NSError?) -> Void in
                
                if imageData != nil {
                    
                    print("image displayed")
                    let image = UIImage(data: imageData!)
                    oneCell.TheImage.image = image
                    
                }
                else {
                    
                    print(error)
                }
            }
            
            
            return oneCell
            
        }
        else{
            
            let threeCell: FriendsViewCell = tableView.dequeueReusableCellWithIdentifier("Cell3") as! FriendsViewCell
            
            threeCell.friendName.text = friends[indexPath.row]
            
            return threeCell
            
        }

    
    }
    
    
    
    


    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let currentUser = PFUser.currentUser()
        let name = currentUser?.username
        if(currentUser != nil){/*
            let query = PFQuery(className: "photos")
            query.whereKey("username", equalTo: name!)
            let runkey = query.orderByDescending("updatedAt")
            runkey.findObjectsInBackgroundWithBlock {
            (photos: [PFObject]?, error: NSError?) -> Void in
            if error == nil{
            if let photos = photos as [PFObject]!{
            for photo in photos{
            let load = photo.objectForKey("imageFile") as! PFFile
            self.images.append(load)
            print(self.images)
            }
            }
            }else{
            print("Error: \(error!)\(error!.userInfo)")
            }
            
            }
            sleep(3)
            do_table_refresh()
            */
            
        }
        else{
            self.performSegueWithIdentifier("goSignIn", sender: self)
        }
        
        
        
    }
    
    
    /*override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }*/
    
    
    @IBAction func logOutUser(sender: UIButton) {
        PFUser.logOut()
        self.performSegueWithIdentifier("goSignIn", sender: self)
    }
    
    
}
