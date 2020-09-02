//
//  Security.swift
//  pullu.test
//
//  Created by Rufat on 8/21/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import Foundation
class Security {
     let defaults = UserDefaults.standard
    func RefreshToken(requestToken:String?) {
   
       self.defaults.set(requestToken, forKey: "requestToken")
    }
    
}

