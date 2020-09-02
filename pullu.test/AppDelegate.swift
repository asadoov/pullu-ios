//
//  AppDelegate.swift
//  pullu.test
//
//  Created by Rufat Asadzade on 1/7/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import Firebase
import FirebaseMessaging
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    let defaults = UserDefaults.standard
  
       var ref: DatabaseReference!

 var window: UIWindow?
let gcmMessageIDKey = "gcm.message_id"
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let menu:MenuController = MenuController()
      if (ConnectionCheck.isConnectedToNetwork() ) {
                      print("Connected")
                      if defaults.string(forKey: "uData") != nil {
                          DispatchQueue.main.async {
                              //self.performSegue(withIdentifier: "homePageSegue", sender: self)
                            menu.updateRootVC(status: true)
                          }
                      }
                      
                      
                  }
                  else{
                      DispatchQueue.main.async {
                        let rootVC : Any
                        
                      
                            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "noInternet")
                        
                        
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = rootVC as? UIViewController
                          //self.performSegue(withIdentifier: "offline", sender: self)
                      }
                      print("disConnected")
                  }
        
        FirebaseApp.configure()
         Messaging.messaging().delegate = self
          UNUserNotificationCenter.current().delegate = self
               
              let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
               //Solicit permission from the user to receive notifications
              UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (_, error) in
                  guard error == nil else{
                      print(error!.localizedDescription)
                      return
                  }
              }
        
        //get application instance ID
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
            }
        }
               
              application.registerForRemoteNotifications()
      //  let center = UNUserNotificationCenter.current()
        
        
        
        
        
//        center.requestAuthorization() { (granted, error) in
//                   if granted {
//                       print("Yay!")
//
//
//
//                   } else {
//                       print("D'oh")
//                   }
//               }
        
     
           return true
        
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
         
        // Print full message.
        print(userInfo)
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
           print("Unable to register for remote notifications: \(error.localizedDescription)")
       }
  
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        
          
       
        Messaging.messaging().subscribe(toTopic: "admin"){ error in
                    if error == nil{
                        print("Subscribed to topic")
                    }
                    else{
                        print("Not Subscribed to topic")
                    }
                }
        
         
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
     
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
//    func scheduleNotification(body:String) {
//        let center = UNUserNotificationCenter.current()
//
//        let content = UNMutableNotificationContent()
//        content.title = "Bildiriş"
//        content.body = body
//        content.categoryIdentifier = "alarm"
//        content.userInfo = ["customData": "fizzbuzz"]
//        content.sound = UNNotificationSound.default
//
//        var dateComponents = DateComponents()
//        dateComponents.hour = 10
//        dateComponents.minute = 30
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//        center.add(request)
//    }
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
