//
//  TabBarController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 2/8/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class TabBarController: UITabBarController {
     let defaults = UserDefaults.standard
     var uID=0
    var userr:User!
    var ref: DatabaseReference!
    var notifications = Array<Notification>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
     //   self.tabBar.barStyle = .blackOpaque
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        
        let udata=defaults.string(forKey: "uData")
                      do{
                          
                          
                          let list  = try
                              JSONDecoder().decode(Array<User>.self, from: udata!.data(using: .utf8)!)
                          
                          // userList=list
                       uID = list[0].id!
                       
                          
                      }
                      catch let jsonErr{
                          print("Error serializing json:",jsonErr)
                      }
               
        
        Auth.auth().signIn(withEmail: "asadzade99@gmail.com", password: "123456") { (user, error) in
                  if error != nil
                  {
                      print(error)
                  }
                  else
                  {
                    let userID = Auth.auth().currentUser!.uid
                      self.ref = Database.database().reference(withPath: "users").child(userID).child("notifications").child(String(self.uID))
                      self.ref.observe(.value, with: { [weak self]  (snapshot) in
                          //print("value: \(snapshot)")
                    
                          var _notification = Array<NotificationModel>()
                        var notificationCount = 0
                          for item in snapshot.children {
                            let task = NotificationModel(snapshot: item as! DataSnapshot)
                            if task.seen == false{
                                notificationCount += 1
                            }
                             
                          }
                        if (notificationCount>0){
                             self?.tabBar.items?[3].badgeValue = String(notificationCount)
                        }
                        else{
                            do {
                                 self?.tabBar.items?[3].badgeValue = nil
                                
                            }
                            catch {
                            
                            
                            }
                           
                            
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
