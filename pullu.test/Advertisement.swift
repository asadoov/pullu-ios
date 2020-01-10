//
//  Advertisement.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/10/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import Foundation
struct Advertisement : Codable {
    
    var id: Int
       var name: String
       var welcomeDescription: String
       var price: String
       var aTypeID: Int
       var aTypeName: String
       var isPaid, mediaTpID, catID: Int
       var catName: String
       var cDate: Date
    
    /*init (json:[String: Any]){
        name=json["name"] as? String ?? ""
        surname=json["surname"] as? String ?? ""
        username=json["username"] as? String ?? ""
        mail=json["mail"] as? String ?? ""
        phone=json["phone"] as? String ?? ""
    }
    */
}
