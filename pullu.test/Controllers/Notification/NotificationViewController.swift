//
//  NotificationViewController.swift
//  pullu.test
//
//  Created by Rufat on 2/6/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class NotificationViewController: UIViewController {
    var userr:User!
    var ref: DatabaseReference!
    var notifications = Array<Notification>()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        Auth.auth().signIn(withEmail: "asadzade99@gmail.com", password: "123456") { (user, error) in
            if error != nil
            {
                print(error)
            }
            else
            {
                self.ref = Database.database().reference(withPath: "users").child("notifications")
                self.ref.observe(.value, with: { [weak self]  (snapshot) in
                    //print("value: \(snapshot)")
                    var _notification = Array<NotificationModel>()
                    for item in snapshot.children {
                        let task = NotificationModel(snapshot: item as! DataSnapshot)
                        _notification.append(task)
                        
                    }
                    DispatchQueue.main.async {
                        self.dismiss(animated: false){
                            let alert = UIAlertController(title: "Bildiriş", message: "\(_notification[0].title!)", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)}
                        
                    }
                  //  print(_notification[0].title!)
                })
                
                // guard var currentUser = Auth.auth().currentUser else {return}
                //self.userr = User(user: currentUser)
                // print(self.userr)
                // print(user)
                //Database.database().reference(withPath: "users").setValue(100)
                // ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("tasks")
                
                /*         do{
                 
                 
                 let notification  = try
                 JSONDecoder().decode(NotificationModel.self, from: Data((value as! String).utf8) )
                 
                 // userList=list
                 if notification.userID=="123"{
                 print(notification.data)
                 
                 }
                 //completionBlock(statistics)
                 
                 }
                 catch let jsonErr{
                 print("Error serializing json:",jsonErr)
                 }
                 
                 */
                
                
            }
        }
        
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
