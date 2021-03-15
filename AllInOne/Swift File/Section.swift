//
//  Section.swift
//  PhotoCaptureApp
//
//  Copyright © 2017 Avion. All rights reserved.
//

import Foundation
struct Section {
    //MARK: - Properties
    var storeName:String!
    var items:[Item_details]
    var expanded:Bool
    //MARK: - initFunction
    init(storeName: String , expanded:Bool, items:[Item_details]) {
        self.storeName = storeName
        self.items = items
        self.expanded = expanded
    }
}
