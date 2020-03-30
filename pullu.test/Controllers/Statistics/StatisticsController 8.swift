//
//  StatisticsController.swift
//  pullu.test
//
//  Created by Rufat on 2/6/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import Firebase

class StatisticsController: UIViewController {
    @IBOutlet weak var allUsers: UILabel!
    @IBOutlet weak var allUsersToday: UILabel!
    @IBOutlet weak var allAds: UILabel!
    @IBOutlet weak var myTodayViews: UILabel!
    @IBOutlet weak var allMyViews: UILabel!
    @IBOutlet weak var myPaidViews: UILabel!
    @IBOutlet weak var myNotPaidViews: UILabel!
    @IBOutlet weak var myAds: UILabel!
    @IBOutlet weak var myNotPaidAds: UILabel!
    @IBOutlet weak var myPaidAds: UILabel!
    var select:dbSelect=dbSelect()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        let mail = defaults.string(forKey: "mail")
        let pass = defaults.string(forKey: "pass")
        select.getStatistics(mail: mail!, pass: pass!) {
            (statistics)
            in
             DispatchQueue.main.async {
            self.allUsers.text=String(statistics.allUsers!)
            self.allUsersToday.text=String(statistics.allUsersToday!)
            self.allAds.text=String(statistics.allAds!)
            self.myTodayViews.text=String(statistics.myTodayViews!)
            self.allMyViews.text=String(statistics.allMyViews!)
            self.myPaidViews.text=String(statistics.myPaidViews!)
            self.myNotPaidViews.text=String(statistics.myNotPaidViews!)
            self.myAds.text=String(statistics.myAds!)
            self.myNotPaidAds.text=String(statistics.myNotPaidAds!)
            self.myPaidAds.text=String(statistics.myPaidAds!)
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
