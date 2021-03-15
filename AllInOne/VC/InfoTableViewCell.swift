//
//  InfoTableViewCell.swift
//  AllInOne
//
//  Created by Apple on 11/2/18.
//  Copyright © 2018 mac08. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
     @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var imgHeightConstraint: NSLayoutConstraint!
    
    var isExpanded:Bool = false
    {
        didSet
        {
            if !isExpanded {
                self.imgHeightConstraint.constant = 0.0
                
            } else {
                self.imgHeightConstraint.constant = 400.0
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
