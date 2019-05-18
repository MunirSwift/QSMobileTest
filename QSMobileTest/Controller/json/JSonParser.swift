//
//  MainMovieParser.swift
//  QSMobileTest
//
//  Created by Rydus on 18/05/2019.
//  Copyright © 2019 Rydus. All rights reserved.
//

import UIKit
import SwiftyJSON

class JsonParser {
    
    //  MARK:   High order function : FILTER results from model
    static func getTitleMovie(keyword:String, model:[ResModel])->[ResModel] {
        if !model.isEmpty {
            let j = model.filter({ (json) -> Bool in
                return json.title.lowercased().hasPrefix(keyword.lowercased()) }) as [ResModel]
            return j
        }
        else {
            return []
        }
    }
    
    //  MARK:   High order function : SORT, map, filter, range, reduce etc...
    static func sortResources(_ jsonArray:[ResModel], _ isAsc:Bool)-> [ResModel] {
        var sortedArray : [ResModel] = []
        if(isAsc) {
            sortedArray = jsonArray.sorted { $0.title < $1.title }
            return sortedArray
        }
        else {
            sortedArray = jsonArray.sorted { $0.title > $1.title }
            return sortedArray
        }
    }
}
