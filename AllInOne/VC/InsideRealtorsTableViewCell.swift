//
//  InsideRealtorsTableViewCell.swift
//  AllInOne
//
//  Created by Apple on 11/16/18.
//  Copyright © 2018 mac08. All rights reserved.
//

import UIKit
import MaterialComponents

class InsideRealtorsTableViewCell: UITableViewCell {

    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var mailLbl: UILabel!
    @IBOutlet weak var mainBtnOut: UIButton!
    @IBOutlet weak var ansBtn: UIButton!
    @IBOutlet weak var ansLbl: UILabel!
    
 @IBOutlet weak var TxtAns: MDCTextField!
  //  var ansTextFieldController: MDCTextInputControllerUnderline!
  
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        //TxtAns.delegate=self
//          ansTextFieldController = MDCTextInputControllerUnderline(textInput: TxtAns)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   

}
