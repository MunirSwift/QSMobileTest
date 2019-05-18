//
//  ContactModel.swift
//  QSMobileTest
//
//  Created by Rydus on 19/05/2019.
//  Copyright © 2019 Rydus. All rights reserved.
//

import Foundation
import SwiftyJSON

//  MARK:   Category Prototype Model
struct ContactModel {
    
    //  collection types
    var website:String
    var email:String
    var phoneNumber:String
    var tollFree:String
    var faxNumber:String
    
    //  dependency injection
    init(dic:JSON) {
        //  collection types
        //json["website"]
        let webArr = dic["website"].arrayObject
        Common.Log(str: (webArr![0] as AnyObject).description)
        website = dic["website"].stringValue 
        email = dic["email"].stringValue 
        phoneNumber = dic["phoneNumber"].stringValue 
        tollFree = dic["tollFree"].stringValue 
        faxNumber = dic["faxNumber"].stringValue 
    }
}
