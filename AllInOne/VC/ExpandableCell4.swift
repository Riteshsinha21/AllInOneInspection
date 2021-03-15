//
//  ExpandableCell4.swift
//  AllInOne
//
//  Created by Apple on 11/13/18.
//  Copyright © 2018 mac08. All rights reserved.
//
//
//import UIKit
//import MaterialComponents
//
//class ExpandableCell4: UITableViewCell {
//
//    @IBOutlet weak var img: UIImageView!
//    @IBOutlet weak var firstName: MDCTextField!
//    @IBOutlet weak var lastName: MDCTextField!
//    @IBOutlet weak var phoneNo: MDCTextField!
//    @IBOutlet weak var address: MDCTextField!
//    @IBOutlet weak var city: MDCTextField!
//    @IBOutlet weak var state: MDCTextField!
//    @IBOutlet weak var email: MDCTextField!
//    
//    
//    @IBOutlet weak var imgHeightConstraint: NSLayoutConstraint!
//    
//    var firstNameTextFieldController: MDCTextInputControllerUnderline!
//    var lastNameTextFieldController: MDCTextInputControllerUnderline!
//    var phoneNoTextFieldController: MDCTextInputControllerUnderline!
//    var addressTextFieldController: MDCTextInputControllerUnderline!
//    var cityTextFieldController: MDCTextInputControllerUnderline!
//    var stateTextFieldController: MDCTextInputControllerUnderline!
//    var emailTextFieldController: MDCTextInputControllerUnderline!
//    var isExpanded:Bool = false
//    {
//        didSet
//        {
//            if !isExpanded {
//                self.imgHeightConstraint.constant = 0.0
//                
//            } else {
//                self.imgHeightConstraint.constant = 300.0
//            }
//        }
//    }
//
//}
