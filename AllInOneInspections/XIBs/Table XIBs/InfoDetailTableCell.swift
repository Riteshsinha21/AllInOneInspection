//
//  InfoDetailTableCell.swift
//  AllInOneInspections
//
//  Created by Ritesh Sinha on 02/05/21.
//

import UIKit

class InfoDetailTableCell: UITableViewCell {

    @IBOutlet weak var cellLbl: UILabel!
    @IBOutlet weak var cellTxtField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
