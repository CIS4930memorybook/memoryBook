//
//  wallViewController.swift
//  memoryBook
//
//  Created by Cody Miller on 12/3/15.
//  Copyright © 2015 Cody Miller. All rights reserved.
//

import Foundation
import Parse

class wallViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var wallMemoryTable: UITableView!
    
    
    var imageFiles = [PFFile]()
    var descriptions = [String]()
    
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
                self.wallMemoryTable.reloadData()
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
        
        return imageFiles.count
        
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
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
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    
    
    
    
    
    

}