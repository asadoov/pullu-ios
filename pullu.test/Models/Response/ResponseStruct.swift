//
//  ResponseStruct.swift
//  pullu.test
//
//  Created by Rufat Asadov on 6/24/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import Foundation
struct ResponseStruct<T:Codable>:Codable{
 public var status:Int?
    public var data:Array<T>
    
    
    
}
