//
//  Categories+CoreDataProperties.swift
//  
//
//  Created by MAC7 on 18/12/18.
//
//

import Foundation
import CoreData


extension Categories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Categories> {
        return NSFetchRequest<Categories>(entityName: "Categories")
    }

    @NSManaged public var c_name: String?

}
