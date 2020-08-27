//
//  ResponseStruct.swift
//  pullu.test
//
//  Created by Javidan Mirza on 7/7/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import Foundation
struct ResponseStruct<T:Codable>:Codable{
    public var requestToken:String?
 public var status:Int?
    public var data:Array<T>
    
    init() {
        
    requestToken = ""
        status = 3
        let dt = Array<T>()
        data = dt
    }
}
