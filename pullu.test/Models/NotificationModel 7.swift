//
//  NotificationModel.swift
//  pullu.test
//
//  Created by Rufat on 2/7/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
class NotificationModel
{
    var title:String?
    var userID:String?
    var ref: DatabaseReference?
    var seen:Bool?
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String : AnyObject]
        title = snapshotValue["title"] as! String
        userID = snapshotValue["userID"] as! String
        seen = snapshotValue["seen"] as! Bool
        ref = snapshot.ref
    }
    
    func convertToDictinary() -> Any{
        return ["title" : title, "userID" : userID, "seen" : seen]
    }
}
