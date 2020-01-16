//
//  Advertisement.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/10/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import Foundation


struct Advertisement : Codable {
    
    var id: Int?
    var name: String?
    var description: String?
    var price: String?
    var aTypeId: Int?
    var aTypeName: String?
    var isPaid, mediaTpId, catId: Int?
    var catName: String?
    var photoUrl: String?
    var photo:  Data?
    
}
