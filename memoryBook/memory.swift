//
//  memory.swift
//  memoryBook
//
//  Created by Cody Miller on 12/2/15.
//  Copyright © 2015 Cody Miller. All rights reserved.
//
import Parse
import Foundation

class memory: PFObject, PFSubclassing {
    @NSManaged var imageFile: PFFile
    @NSManaged var userName: PFUser
    @NSManaged var desc: String?
    @NSManaged var location: PFGeoPoint
    
    //1
    class func parseClassName() -> String {
        return "memory"
    }
    
    //2
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    override class func query() -> PFQuery? {
        let query = PFQuery(className: memory.parseClassName()) //1
        query.includeKey("userName") //2
        query.orderByDescending("createdAt") //3
        return query
    }
    
    init(imageFile: PFFile, userName: PFUser, desc: String?, location: PFGeoPoint) {
        super.init()
        
        self.imageFile = imageFile
        self.userName = userName
        self.desc = desc
        self.location = location
    }
    
    override init() {
        super.init()
    }
    
}