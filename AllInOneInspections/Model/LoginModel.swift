//
//  LoginModel.swift
//  AllInOneInspections
//
//  Created by Ritesh Sinha on 28/04/21.
//

import Foundation
import UIKit

struct inspectorDetail_struct {
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
}

struct inspectionList_struct {
    var inspection_id: String = ""
    var inspection_address_2: String = ""
    var time_of_inspection: String = ""
    var is_agreement: Bool = false
    var inspection_country: String = ""
    var date_of_inspection: String = ""
    var client_name: String = ""
    var inspection_name: String = ""
    var inspection_address: String = ""
    var inspection_state: String = ""
    var inspection_zip: String = ""
}
