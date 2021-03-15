//
//  DashboardCell.swift
//  AllInOne
//
//  Created by mac08 on 29/10/18.
//  Copyright © 2018 mac08. All rights reserved.
//

import UIKit

class DashboardCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //Outlets..
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var clientLastName: UILabel!
    @IBOutlet var propertyName: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var agentNameLbl: UILabel!
     @IBOutlet weak var lbl_syncOrNot: UILabel!
    
    @IBOutlet weak var lbl_InvoiceNo: UILabel!
    @IBOutlet weak var lbl_typesOfInspection: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
