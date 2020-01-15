//
//  User.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/7/20.
//  Copyright © 2020 Javidan Mirza. All rights reserved.
//

import Foundation
struct User:Codable{
    
    var name: String?
    var surname: String?

    var mail: String?
    var phone: String?
    var birthDate: String?
    var gender: String?
    var city: String?
    var profession: String?
    var regDate: String?
    
    
    /*init (json:[String: Any]){
     name=json["name"] as? String ?? ""
     surname=json["surname"] as? String ?? ""
     username=json["username"] as? String ?? ""
     mail=json["mail"] as? String ?? ""
     phone=json["phone"] as? String ?? ""
     }
     */
}
