//
//  AddressModel.swift
//  QSMobileTest
//
//  Created by Rydus on 19/05/2019.
//  Copyright © 2019 Rydus. All rights reserved.
//

import Foundation
import SwiftyJSON

//  MARK:   Category Prototype Model
struct AddressModel {
    
    //  string types
    var address1:String
    var zipCode:String
    var city:String
    var state:String
    var country:String
    var gps:JSON
    
    //  dependency injection
    init(json:JSON) {
        //  string types
        address1 = json["address1"].stringValue
        zipCode = json["zipCode"].stringValue
        city = json["city"].stringValue
        state = json["state"].stringValue
        country = json["country"].stringValue
        
        //collection type
        gps = json["gps"]
    }
}
