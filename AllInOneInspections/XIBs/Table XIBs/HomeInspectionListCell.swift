//
//  HomeInspectionListCell.swift
//  AllInOneInspections
//
//  Created by Ritesh Sinha on 27/04/21.
//

import UIKit

class HomeInspectionListCell: UITableViewCell {

    @IBOutlet weak var cellAgreementBtn: UIButton!
    @IBOutlet weak var cellSyncBtn: UIButton!
    @IBOutlet weak var cellMapBtn: UIButton!
    @IBOutlet weak var cellDateLbl: UILabel!
    @IBOutlet weak var cellTimeLbl: UILabel!
    @IBOutlet weak var cellLocationLbl: UILabel!
    @IBOutlet weak var cellPropertyName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
