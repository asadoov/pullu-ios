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
class UserStruct:Codable{
     var userToken:String?
    var id:Int?
    var firebaseID:String?
    var name: String?
    var surname: String?
    var mail: String?
    var phone: Int64?
    var birthDate: String?
    var genderID: Int?
    var countryID: Int?
    var cityID: Int?
    var photoURL: String?
    var regDate: String?
    var balance:String?
    var earning:String?
    
    
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
