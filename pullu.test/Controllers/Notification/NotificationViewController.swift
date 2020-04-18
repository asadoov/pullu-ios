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

class NotificationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var userr:User!
    var ref: DatabaseReference!
    var notifications = Array<NotificationModel>()
    @IBOutlet weak var notificationTable: UITableView!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        self.tabBarController?.viewControllers?[3].tabBarItem.badgeValue = nil
        Auth.auth().signIn(withEmail: "asadzade99@gmail.com", password: "123456") { (user, error) in
            if error != nil
            {
                print(error)
            }
            else
            {
                let userID = Auth.auth().currentUser!.uid
                self.ref = Database.database().reference(withPath: "users").child(userID).child("notifications")
                self.ref.observe(.value, with: { [weak self]  (snapshot) in
                    //print("value: \(snapshot)")
                    
                    for item in snapshot.children {
                        let task = NotificationModel(snapshot: item as! DataSnapshot)
                        self!.notifications.append(task)
                        
                    }
                    
                    self?.notificationTable.reloadData()
                    
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
        notificationTable.delegate = self
        notificationTable.dataSource = self
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notifications.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NotificationCell = (tableView.dequeueReusableCell(withIdentifier: "notifyCell", for: indexPath) as! NotificationCell)
        cell.object = notifications[indexPath.row]
        //cell.delegate = self
        cell.reloadData()
        //cell.object = dataArray[indexPath.row]
        //     cell.delegate = self
        
        
        // Configure the cell...
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 75
        
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
