//
//  NewAdvertisementStruct.swift
//  pullu.test
//
//  Created by Rufat on 2/20/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import Foundation
class NewAdvertisementStruct: Codable {
    var mail:String?
    var pass:String?
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
    var aProfessionID:Int?
    var mediaBase64:Array<String>?
}
