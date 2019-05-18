//
//  Common.swift
//  QSMobileTest
//
//  Created by Rydus on 18/05/2019.
//  Copyright © 2019 Rydus. All rights reserved.
//

import Foundation

final class Common {
    
    static func Log(str:String) {
        debugPrint("movie-log::%@", str);
    }
    
    static func isEqual<T:Equatable>(_ arg1:T, _ arg2:T)->Bool {
        return arg1 == arg2
    }
}
