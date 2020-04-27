//
//  AppDelegate.swift
//  pullu.test
//
//  Created by Javidan Mirza on 1/7/20.
//  Copyright © 2020 Javidan Mirza. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import Firebase
import FirebaseDatabase
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let defaults = UserDefaults.standard
   var uID=0
       var ref: DatabaseReference!

 var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        
     
           return true
        
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        let center = UNUserNotificationCenter.current()

        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
                
                let udata=self.defaults.string(forKey: "uData")
                if udata != nil
                {
                                  do{
                                      
                                      
                                      let list  = try
                                          JSONDecoder().decode(Array<User>.self, from: udata!.data(using: .utf8)!)
                                      
                                      // userList=list
                                    self.uID = list[0].id!
                                   
                                      
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
                                
                                 for item in snapshot.children {
                                     let task = NotificationModel(snapshot: item as! DataSnapshot)
                                    if (task.seen == false){
                                        
                                        self!.scheduleNotification(body: task.title!)
                                        
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
                
            } else {
                print("D'oh")
            }
        }
        return true
    }
  
    func scheduleNotification(body:String) {
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Bildiriş"
        content.body = body
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
//    func scheduleNotification() {
//           let center = UNUserNotificationCenter.current()
//
//           let content = UNMutableNotificationContent()
//           content.title = "Late wake up call"
//           content.body = "The early bird catches the worm, but the second mouse gets the cheese."
//           content.categoryIdentifier = "alarm"
//           content.userInfo = ["customData": "fizzbuzz"]
//           content.sound = UNNotificationSound.default
//
//           var dateComponents = DateComponents()
//           dateComponents.hour = 10
//           dateComponents.minute = 30
//           let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//
//           let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//           center.add(request)
//       }
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "pullu_test")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
