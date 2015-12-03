//
//  MemoryViewCell.swift
//  memoryBook
//
//  Created by Taylor Lindquist on 12/2/15.
//  Copyright © 2015 Cody Miller. All rights reserved.
//

import UIKit
import Parse



class MemoryViewCell: UITableViewCell {
    
    @IBOutlet weak var TheImage: UIImageView!
    @IBOutlet weak var TheDesc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
    

}
