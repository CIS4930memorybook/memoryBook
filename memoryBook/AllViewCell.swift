//
//  AllViewCell.swift
//  memoryBook
//
//  
//  Copyright © 2015 Cody Miller. All rights reserved.
//


import UIKit
import Parse

class AllViewCell: UITableViewCell {
    
    @IBOutlet weak var Usersname: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}