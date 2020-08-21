//
//  NewUser.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/11/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import Foundation
struct NewUser:Codable{
    
    var name: String?
    var surname: String?
    var mail: String?
    var phone: Int?
    var pass: String?
    var bDate: String?
    var gender: Int?
    var country: Int?
    var city: Int?
    var interestIds: Array<Int>?
    var otp:Int?
}
