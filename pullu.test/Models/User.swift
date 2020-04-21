//
//  User.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/7/20.
//  Copyright © 2020 Javidan Mirza. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth
struct User:Codable{
    var id:Int?
    var firebaseID:String?
    var name: String?
    var surname: String?

    var mail: String?
    var phone: String?
    var birthDate: String?
    var gender: String?
     var countryID: String?
    var cityID: String?
    var profession: String?
    var regDate: String?
    var balance:String?
    var earning:String?
     var pass: String?
    
    init(user: FirebaseAuth.User) {
        self.firebaseID = user.uid
        self.mail = user.email!
    }
    
    /*init (json:[String: Any]){
     name=json["name"] as? String ?? ""
     surname=json["surname"] as? String ?? ""
     username=json["username"] as? String ?? ""
     mail=json["mail"] as? String ?? ""
     phone=json["phone"] as? String ?? ""
     }
     */
}
