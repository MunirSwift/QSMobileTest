//
//  ResModel.swift
//  QSMobileTest
//
//  Created by Rydus on 18/05/2019.
//  Copyright © 2019 Rydus. All rights reserved.
//

import Foundation
import SwiftyJSON

//  MARK:   Resources Model
struct ResModel {
    
    //  string types
    var slug:String
    var title:String
    var photo:String
    var description:String
    
    //  collections types
    var addresses : JSON
    var contactInfo : Dictionary<String, Any>
    var bizHours : JSON
    var socialMedia : JSON
    
    //  dependency injection
    init(json:JSON) {
        
        //  string types
        slug = json["slug"].stringValue
        title = json["title"].stringValue
        photo = json["photo"].stringValue
        description = json["description"].stringValue
        
        //  collection types
        addresses = json["addresses"]
        contactInfo = json["contactInfo"].dictionaryValue
        bizHours = json["bizHours"]
        socialMedia = json["socialMedia"]
    }
}
