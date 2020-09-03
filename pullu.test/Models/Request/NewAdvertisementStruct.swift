//
//  NewAdvertisementStruct.swift
//  pullu.test
//
//  Created by Rufat on 2/20/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import Foundation
class NewAdvertisementStruct: Codable {
    
    var isPaid:Int?
    var aTypeID:Int?
    var aCategoryID:Int?
    var aMediaTypeID:Int?
    var aTitle:String?
    var aTrfID:Int?
    var aDescription:String?
    var aPrice:String?
    var aCountryID:Int?
    var aCityID:Int?
    var aGenderID:Int?
    var aAgeRangeID:Int?
    var aBackgroundUrl:String?
    var files:Array<Data>?
    var aInterestIds:Array<Int>?
        var videoPathExtension:String?
}
