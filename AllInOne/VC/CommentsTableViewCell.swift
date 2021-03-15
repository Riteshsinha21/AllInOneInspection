//
//  CommentsTableViewCell.swift
//  AllInOne
//
//  Created by Admin on 11/03/19.
//  Copyright © 2019 mac08. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {
    
@IBOutlet weak var txt_comments: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
