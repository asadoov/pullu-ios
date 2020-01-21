//
//  AboutAdvertController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/17/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class AboutAdvertController: UIViewController {
        let defaults = UserDefaults.standard
    var advertID:Int?
    var select:dbSelect=dbSelect()
    var userData = Array<User>()
    @IBOutlet weak var advName: UILabel!
    
    @IBOutlet weak var advDescription: UILabel!
    
    @IBOutlet weak var advType: UILabel!
    
    @IBOutlet weak var balance: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
                 
        
        // Do any additional setup after loading the view.
        select.getAdvertById(advertID: advertID)
        {
            (list)
            in
        
            do{
                let udata = self.defaults.string(forKey: "uData")

                self.userData  = try
                   JSONDecoder().decode(Array<User>.self, from: udata!.data(using: .utf8)!)
            }
            catch let jsonErr{
                print("Error serializing json:",jsonErr)
            }
            
            DispatchQueue.main.async {
                
                //  self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
                //self.tableView.reloadData()
                
                // self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
                
                self.advName.text=list[0].name!
                self.advDescription.text = list[0].description!
                self.advType.text=list[0].aTypeName
                self.balance.text = "\(self.userData[0].earning!) AZN"
                //  self.tableView.reloadData()
                
                
                
                
                
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
