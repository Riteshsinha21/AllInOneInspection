//
//  Item_details.swift
//  PhotoCaptureApp
//
//  Copyright © 2017 Avion. All rights reserved.
//

import Foundation
struct Item_details {
    
    //MARK: - Properties
    var itemName:String!
    var amount:String!
    var imageURL:String!
    var date:String!
    var item_id:String!
    //MARK: - initFuntion
    init(itemName:String , amount:String , imageURL:String, date:String , item_id:String )  {
        self.itemName = itemName
        self.amount = amount
        self.imageURL = imageURL
        self.date = date
        self.item_id = item_id
    }
    
}
