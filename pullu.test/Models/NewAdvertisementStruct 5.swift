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
    var title:String?
    var trfID:Int?
    var description:String?
    var price:Double?
    var countryID:Int?
    var cityID:Int?
    var ageRangeID:Int?
    var professionID:Int?
    var mediaBase64:String?
}
