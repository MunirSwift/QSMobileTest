//
//  CatModel.swift
//  QSMobileTest
//
//  Created by Rydus on 18/05/2019.
//  Copyright © 2019 Rydus. All rights reserved.
//

import Foundation
import SwiftyJSON

//  MARK:   Category Prototype Model
struct CatModel {
    
    //  string types
    var slug:String
    var title:String
    var description:String
    
    //  dependency injection
    init(json:JSON) {
        //  string types
        slug = json["slug"].stringValue
        title = json["title"].stringValue
        description = json["description"].stringValue
    }
}
