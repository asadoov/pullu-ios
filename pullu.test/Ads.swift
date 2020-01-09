//
//  Ads.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/9/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import Foundation
struct Ads:Decodable{
    
    var id : Int
    var isPaid : Int
    var name : String
    var description : String
    var price : String
    var aTypeId : Int
    var aTypeName : String
    var mediaTpId : Int
    var catId : Int
    var catName : String
    var cDate : Date
    var photoUrl : String
    /*init (json:[String: Any]){
     name=json["name"] as? String ?? ""
     surname=json["surname"] as? String ?? ""
     username=json["username"] as? String ?? ""
     mail=json["mail"] as? String ?? ""
     phone=json["phone"] as? String ?? ""
     }
     */
}
