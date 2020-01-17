//
//  AboutAdvertController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/17/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class AboutAdvertController: UIViewController {
    var advertID:Int?
    var select:dbSelect=dbSelect()
    
    @IBOutlet weak var advName: UILabel!
    
    @IBOutlet weak var advDescription: UILabel!
    
    @IBOutlet weak var advType: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        select.getAdvertById(advertID: advertID)
        {
            (list)
            in
            
            DispatchQueue.main.async {
                
                //  self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
                //self.tableView.reloadData()
                
                // self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
                
                self.advName.text=list[0].name!
                self.advDescription.text = list[0].description!
                self.advType.text=list[0].aTypeName
                
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
