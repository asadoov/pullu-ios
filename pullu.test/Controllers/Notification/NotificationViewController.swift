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
import MBProgressHUD
class NotificationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let defaults = UserDefaults.standard
    var userr:User!
    var ref: DatabaseReference!
    var notifications = Array<NotificationModel>()
    @IBOutlet weak var notificationTable: UITableView!
    var loadingAlert:MBProgressHUD?
    var uID=0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingAlert!.mode = MBProgressHUDMode.indeterminate
        loadingAlert!.label.text="Bildirişlər yüklənir..."
        //loadingAlert!.detailsLabel.text = "Reklamları gətirirk..."
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        self.tabBarController?.viewControllers?[3].tabBarItem.badgeValue = nil
        //        scheduleNotification()
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
                    self!.notifications.removeAll()
                    for item in snapshot.children {
                        let task = NotificationModel(snapshot: item as! DataSnapshot)
                        
                        
                        self!.notifications.append(task)
                        if task.seen == false{
                            (item as AnyObject).ref.updateChildValues(["seen":true])
                            // self!.sendNotification(body: task.title!)
                            
                        }
                        
                        
                    }
                    
                    self!.loadingAlert!.hide(animated: true)
                    self!.notifications.reverse()
                    self?.notificationTable.reloadData()
                    
                    //  print(_notification[0].title!)
                })
                //self.ref.updateChildValues(["seen":true])
                
                // guard var currentUser = Auth.auth().currentUser else {return}
                //self.userr = User(user: currentUser)
                // print(self.userr)
                // print(user)
                
                
                
                
                //   Database.database().reference(withPath: "users").child(userID).child("notifications").child(String(self.uID)).childByAutoId().key.updateChildValues(["seen": true])
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
    
    //    func sendNotification(body:String) {
    //        let center = UNUserNotificationCenter.current()
    //
    //        let content = UNMutableNotificationContent()
    //        content.title = "Pullu"
    //        content.body = body
    //        content.categoryIdentifier = "alarm"
    //        content.userInfo = ["customData": "fizzbuzz"]
    //        content.sound = UNNotificationSound.default
    //
    ////        var dateComponents = DateComponents()
    ////        dateComponents.hour = 10
    ////        dateComponents.minute = 30
    //        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0, repeats: false)
    //
    //        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    //        center.add(request)
    //    }
    
    
    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let cell: NotificationCell = (tableView.dequeueReusableCell(withIdentifier: "notifyCell", for: indexPath) as! NotificationCell)
        //        cell.object =
        
        
        //print(advertID!)
        let moreAlert = UIAlertController(title: "\(notifications[indexPath.row].title!)", message: "\(notifications[indexPath.row].body!)", preferredStyle: UIAlertController.Style.alert)
        moreAlert.addAction(UIAlertAction(title: "Bağla", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(moreAlert, animated: true, completion: nil)
        //print(cell.object?.name)
        //cell.delegate = self
        
        
        //cell.reloadData()
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
